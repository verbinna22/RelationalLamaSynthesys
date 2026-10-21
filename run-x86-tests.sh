#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$project_root"
build_dir=$(mktemp -d "${TMPDIR:-/tmp}/lama-x86-tests.XXXXXXXX")
trap 'rm -rf -- "$build_dir"' EXIT
test_timeout=${TEST_TIMEOUT:-120s}
command -v timeout >/dev/null || { echo 'Required command not found: timeout' >&2; exit 2; }

find . -path './.git' -prune -o -type f -name '*.s' -print0 | LC_ALL=C sort -z > "$build_dir/files"
mapfile -d '' -t assembly_files < "$build_dir/files"
# assembly_files=("./lama-artifacts/test074.s") # DEBUG: isolate the failing fixture.
if (( ${#assembly_files[@]} == 0 )); then
    echo 'No .s files found.' >&2
    exit 2
fi

ghc -v0 -O0 -outputdir "$build_dir" -o "$build_dir/run-x86-test" \
    haskellInterpreter/X86.hs haskellInterpreter/AssemblyParser.hs \
    haskellInterpreter/RunX86Test.hs

passed_count=0
failed_count=0
for assembly_path in "${assembly_files[@]}"; do
    test_prefix=${assembly_path%.s}
    input_path=$test_prefix.input
    output_path=$test_prefix.output
    if [[ ! -f "$input_path" || ! -f "$output_path" ]]; then
        printf 'FAIL %s: missing .input or .output file\n' "$assembly_path" >&2
        failed_count=$((failed_count + 1))
        continue
    fi
    if timeout -- "$test_timeout" "$build_dir/run-x86-test" "$assembly_path" "$input_path" "$output_path"; then
        passed_count=$((passed_count + 1))
    else
        test_status=$?
        printf 'FAIL %s: process exit status %s' "$assembly_path" "$test_status" >&2
        if (( test_status == 124 )); then printf ' (timeout)' >&2; fi
        printf '\n' >&2
        failed_count=$((failed_count + 1))
    fi
done
printf 'TOTAL %s: PASS %s, FAIL %s\n' "${#assembly_files[@]}" "$passed_count" "$failed_count"
(( failed_count == 0 ))
