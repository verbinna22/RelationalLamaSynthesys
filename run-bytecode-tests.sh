#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$project_root"
build_dir=$(mktemp -d "${TMPDIR:-/tmp}/lama-bytecode-tests.XXXXXXXX")
trap 'rm -rf -- "$build_dir"' EXIT
test_timeout=${TEST_TIMEOUT:-120s}
command -v timeout >/dev/null || { echo 'Required command not found: timeout' >&2; exit 2; }

find . -path './.git' -prune -o -type f -name '*.bc' -print0 | LC_ALL=C sort -z > "$build_dir/files"
mapfile -d '' -t bytecode_files < "$build_dir/files"
# bytecode_files=("./lama-artifacts/test099.bc") # DEBUG: isolate the failing fixture.
if (( ${#bytecode_files[@]} == 0 )); then
    echo 'No .bc files found.' >&2
    exit 2
fi

ghc -v0 -O0 -outputdir "$build_dir" -o "$build_dir/run-bytecode-test" \
    haskellInterpreter/SM.hs haskellInterpreter/BytecodeParser.hs \
    haskellInterpreter/RunBytecodeTest.hs

passed_count=0
failed_count=0
for bytecode_path in "${bytecode_files[@]}"; do
    test_prefix=${bytecode_path%.bc}
    input_path=$test_prefix.input
    output_path=$test_prefix.output
    if [[ ! -f "$input_path" || ! -f "$output_path" ]]; then
        printf 'FAIL %s: missing .input or .output file\n' "$bytecode_path" >&2
        failed_count=$((failed_count + 1))
        continue
    fi
    if timeout -- "$test_timeout" "$build_dir/run-bytecode-test" "$bytecode_path" "$input_path" "$output_path"; then
        passed_count=$((passed_count + 1))
    else
        test_status=$?
        printf 'FAIL %s: process exit status %s' "$bytecode_path" "$test_status" >&2
        if (( test_status == 124 )); then printf ' (timeout)' >&2; fi
        printf '\n' >&2
        failed_count=$((failed_count + 1))
    fi
done
printf 'TOTAL %s: PASS %s, FAIL %s\n' "${#bytecode_files[@]}" "$passed_count" "$failed_count"
(( failed_count == 0 ))
