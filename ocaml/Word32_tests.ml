open OCanren

let expect_words description expected goal =
  let actual = Stream.take @@ run q goal (fun answer ->
    Word32.to_int (answer#reify Word32.prj_exn)) in
  if List.sort compare actual <> List.sort compare expected then
    failwith (Printf.sprintf "Word32 %s: expected [%s], got [%s]" description
      (String.concat "; " (List.map string_of_int expected))
      (String.concat "; " (List.map string_of_int actual)))

let expect_ranges description expected answers =
  let interval answer =
    let rec read index fixed seen minimum maximum = function
      | Value Std.List.Nil ->
          assert (index = Word32.width);
          (minimum, maximum)
      | Value (Std.List.Cons (bit, tail)) ->
          assert (index < Word32.width);
          let weight = 1 lsl index in
          (match bit with
           | Value bit ->
               read (index + 1) true seen
                 (if bit then minimum lor weight else minimum)
                 (if bit then maximum lor weight else maximum) tail
           | Var (id, []) ->
               assert (not fixed && not (List.mem id seen));
               read (index + 1) false (id :: seen) minimum (maximum lor weight) tail
           | _ -> failwith (description ^ ": constrained bit in a range"))
      | _ -> failwith (description ^ ": incomplete word")
    in
    read 0 false [] 0 0 answer
  in
  let intervals = List.sort compare (List.map interval answers) in
  let merged = List.fold_left (fun ranges (minimum, maximum) ->
    match ranges with
    | (previous_minimum, previous_maximum) :: rest ->
        if minimum <= previous_maximum then failwith (description ^ ": overlapping answers");
        if minimum = previous_maximum + 1 then (previous_minimum, maximum) :: rest
        else (minimum, maximum) :: ranges
    | [] -> [(minimum, maximum)]
  ) [] intervals in
  if List.rev merged <> expected then failwith (description ^ ": unexpected ranges")

let test_conversions () =
  List.iter (fun value ->
    let bits = Word32.of_int value in
    assert (List.length bits = 32);
    assert (Word32.to_int bits = value);
    expect_words "int/inj/prj_exn round trip" [value]
      (fun result -> result === Word32.inj bits)
  ) [0; 1; 2; 3; 31; 32; 255; 0x7fff_ffff; 0x8000_0000;
     0xaaaa_aaaa; 0xffff_ffff];
  assert (Word32.of_int 5 = [true; false; true] @ List.init 29 (fun _ -> false));
  assert (Word32.of_int (-1) = List.init 32 (fun _ -> true));
  assert (Word32.to_int (Word32.of_int (-2)) = 0xffff_fffe);
  assert (Word32.to_int (Word32.of_int 0x1_0000_0000) = 0);
  assert (Word32.to_int (Word32.of_int 0x1_0000_0001) = 1);
  List.iter (fun count ->
    let malformed = List.init count (fun _ -> false) in
    assert (try ignore (Word32.to_int malformed); false with Invalid_argument _ -> true);
    assert (try ignore (Word32.inj malformed); false with Invalid_argument _ -> true);
    assert (try
      ignore (Stream.take @@ run q
        (fun result -> result === Std.list inj malformed)
        (fun answer -> answer#reify Word32.prj_exn));
      false
    with Invalid_argument _ -> true)
  ) [0; 31; 33];
  Printf.printf "Word32 int conversions and width checks: OK\n%!"

let test_reifiers () =
  let tail = Std.list inj (List.init 31 (fun _ -> false)) in
  let goal result = ocanren { fresh bit in result == bit :: tail } in
  let answers = Stream.take @@ run q goal (fun answer -> answer#reify Word32.reify) in
  assert (match answers with
    | [Value (Std.List.Cons (Var _, rest))] ->
        rest = List.fold_right
          (fun bit tail -> Value (Std.List.Cons (Value bit, tail)))
          (List.init 31 (fun _ -> false)) (Value Std.List.Nil)
    | _ -> false);
  assert (try
    ignore (Stream.take @@ run q goal (fun answer -> answer#reify Word32.prj_exn));
    false
  with Not_a_value -> true);
  let ground = Stream.take @@ run q
    (fun result -> result === Word32.word 5)
    (fun answer -> answer#reify Word32.reify) in
  assert (ground = [List.fold_right
    (fun bit tail -> Value (Std.List.Cons (Value bit, tail)))
    ([true; false; true] @ List.init 29 (fun _ -> false)) (Value Std.List.Nil)]);
  Printf.printf "Word32 prj_exn/reify, including a free bit: OK\n%!"

let test_nat () =
  let samples = List.init 65 (fun value -> value) @ [127; 128; 255; 256; 511; 512] in
  List.iter (fun value ->
    let natural = Std.Nat.of_int value in
    let bits = Word32.of_nat natural in
    assert (Word32.to_int bits = value);
    assert (Word32.to_nat bits = natural);
    expect_words "from_nato" [value] (Word32.from_nato (Std.Nat.nat natural));
    let naturals = Stream.take @@ run q (Word32.to_nato (Word32.word value))
      (fun answer -> Std.Nat.to_int (answer#reify Std.Nat.prj_exn)) in
    assert (naturals = [value])
  ) samples;
  expect_words "Nat through addition" [42] (fun result -> ocanren {
    fresh left, right in
      Word32.from_nato 19 left & Word32.from_nato 23 right &
      Word32.addo left right result
  });
  let naturals = Stream.take @@ run q (fun natural -> ocanren {
    fresh product in
      Word32.mulo !(Word32.word 6) !(Word32.word 7) product &
      Word32.to_nato product natural
  }) (fun answer -> Std.Nat.to_int (answer#reify Std.Nat.prj_exn)) in
  assert (naturals = [42]);
  let too_large = Stream.take @@ run q (Word32.nat_bitso true 3 (Std.nat 8))
    (fun answer -> answer#reify (Std.List.reify Std.Bool.reify)) in
  assert (too_large = []);
  expect_words "inconsistent Nat conversion" [] (fun result -> ocanren {
    Word32.from_nato 7 result & result == !(Word32.word 8)
  });
  Printf.printf "Word32 Nat conversions: %d round trips and relational composition OK\n%!"
    (List.length samples)

let test_arithmetic () =
  List.iter (fun (left, right, sum) ->
    expect_words "addition" [sum] (Word32.addo (Word32.word left) (Word32.word right));
    expect_words "subtraction" [left] (Word32.subo (Word32.word sum) (Word32.word right))
  ) [(0, 0, 0); (5, 7, 12); (0xffff_ffff, 1, 0);
     (0x8000_0000, 0x8000_0000, 0); (0x7fff_ffff, 1, 0x8000_0000);
     (0xaaaa_aaaa, 0x5555_5555, 0xffff_ffff)];
  List.iter (fun (left, right, product) ->
    expect_words "multiplication" [product] (Word32.mulo (Word32.word left) (Word32.word right))
  ) [(0, 0, 0); (0, 0xffff_ffff, 0); (0xffff_ffff, 0, 0);
     (1, 0xffff_ffff, 0xffff_ffff); (6, 7, 42); (13, 11, 143);
     (0x8000_0000, 2, 0); (0x10000, 0x10000, 0);
     (0xffff_ffff, 0xffff_ffff, 1); (0xffff_ffff, 2, 0xffff_fffe)];
  let samples = [0; 1; 2; 3; 31; 0x10001; 0x7fff_ffff;
                 0x8000_0000; 0xaaaa_aaaa; 0xffff_ffff] in
  List.iter (fun left ->
    List.iter (fun right ->
      expect_words "addition reference" [(left + right) land Word32.max_value]
        (Word32.addo (Word32.word left) (Word32.word right));
      expect_words "subtraction reference" [(left - right) land Word32.max_value]
        (Word32.subo (Word32.word left) (Word32.word right));
      let product = Int64.to_int (Int64.logand
        (Int64.mul (Int64.of_int left) (Int64.of_int right)) 0xffff_ffffL) in
      expect_words "multiplication reference" [product]
        (Word32.mulo (Word32.word left) (Word32.word right))
    ) samples
  ) samples;
  Printf.printf "Word32 arithmetic: boundaries and %d reference cases OK\n%!"
    (3 * List.length samples * List.length samples)

let test_backwards () =
  expect_words "missing left addend" [0xffff_ffff]
    (fun left -> Word32.addo left (Word32.word 1) (Word32.word 0));
  expect_words "missing right addend" [0xffff_ffff]
    (fun right -> Word32.addo (Word32.word 1) right (Word32.word 0));
  expect_words "missing minuend" [0]
    (fun left -> Word32.subo left (Word32.word 1) (Word32.word 0xffff_ffff));
  expect_words "missing subtrahend" [1]
    (fun right -> Word32.subo (Word32.word 0) right (Word32.word 0xffff_ffff));
  expect_words "missing multiplier" [7]
    (fun left -> Word32.mulo left (Word32.word 3) (Word32.word 21));
  expect_words "missing multiplicand" [7]
    (fun right -> Word32.mulo (Word32.word 3) right (Word32.word 21));
  expect_words "modular inverse" [0xaaaa_aaab]
    (fun left -> Word32.mulo left (Word32.word 3) (Word32.word 1));
  expect_words "modular inverse on the right" [0xaaaa_aaab]
    (fun right -> Word32.mulo (Word32.word 3) right (Word32.word 1));
  expect_words "two modular solutions" [3; 0x8000_0003]
    (fun left -> Word32.mulo left (Word32.word 2) (Word32.word 6));
  expect_words "two modular solutions on the right" [3; 0x8000_0003]
    (fun right -> Word32.mulo (Word32.word 2) right (Word32.word 6));
  expect_words "unsatisfiable multiplication" []
    (fun left -> Word32.mulo left (Word32.word 2) (Word32.word 1));
  expect_words "unsatisfiable multiplication on the right" []
    (fun right -> Word32.mulo (Word32.word 2) right (Word32.word 1));
  Printf.printf "Word32 backward arithmetic: unique, multiple and absent solutions OK\n%!"

let test_comparisons () =
  let samples = [0; 1; 2; 3; 31; 0x10001; 0x7fff_ffff;
                 0x8000_0000; 0xaaaa_aaaa; 0xffff_ffff] in
  List.iter (fun left ->
    List.iter (fun right ->
      List.iter (fun (relation, expected) ->
        let actual = Stream.take @@ run q (relation (Word32.word left) (Word32.word right))
          (fun answer -> answer#reify Std.Bool.prj_exn) in
        assert (actual = [expected])
      ) [(Word32.lto, left < right); (Word32.gto, left > right); (Word32.eqo, left = right)]
    ) samples
  ) samples;
  Printf.printf "Word32 comparisons: %d unsigned reference cases OK\n%!"
    (3 * List.length samples * List.length samples)

let test_comparisons_backwards () =
  let check description expected goal =
    let answers = Stream.take @@ run q goal (fun answer -> answer#reify Word32.reify) in
    expect_ranges description expected answers
  in
  let maximum = Word32.max_value in
  check "less than 3" [(0, 2)]
    (fun value -> Word32.lto value (Word32.word 3) (inj true));
  check "greater than 3" [(4, maximum)]
    (fun value -> Word32.gto value (Word32.word 3) (inj true));
  check "right operand greater than 3" [(4, maximum)]
    (fun value -> Word32.lto (Word32.word 3) value (inj true));
  check "right operand less than 3" [(0, 2)]
    (fun value -> Word32.gto (Word32.word 3) value (inj true));
  check "not less than 3" [(3, maximum)]
    (fun value -> Word32.lto value (Word32.word 3) (inj false));
  check "not greater than 3" [(0, 3)]
    (fun value -> Word32.gto value (Word32.word 3) (inj false));
  check "not equal to 3" [(0, 2); (4, maximum)]
    (fun value -> Word32.eqo value (Word32.word 3) (inj false));
  expect_words "equal to maximum" [maximum]
    (fun value -> Word32.eqo value (Word32.word maximum) (inj true));
  check "less than zero" []
    (fun value -> Word32.lto value (Word32.word 0) (inj true));
  check "greater than maximum" []
    (fun value -> Word32.gto value (Word32.word maximum) (inj true));
  check "not less than maximum" [(maximum, maximum)]
    (fun value -> Word32.lto value (Word32.word maximum) (inj false));
  check "not greater than zero" [(0, 0)]
    (fun value -> Word32.gto value (Word32.word 0) (inj false));
  check "self equality" [(0, maximum)]
    (fun value -> Word32.eqo value value (inj true));
  check "self inequality" []
    (fun value -> Word32.eqo value value (inj false));
  check "self less than" []
    (fun value -> Word32.lto value value (inj true));
  check "self not less than" [(0, maximum)]
    (fun value -> Word32.lto value value (inj false));
  Printf.printf "Word32 inverse comparisons: exact ranges, boundaries and shared variables OK\n%!"

let expect_division description ~dividend ~divisor expected =
  let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
  let actual = Stream.take @@ run q (fun answer -> ocanren {
    fresh quotient, remainder in
      Word32.divmodo !(Word32.word dividend) !(Word32.word divisor) quotient remainder &
      answer == Std.pair quotient remainder
  }) (fun answer -> answer#reify (Std.Pair.prj_exn number_prj number_prj)) in
  let show_pair (quotient, remainder) = Printf.sprintf "(%d, %d)" quotient remainder in
  if actual <> expected then
    failwith (Printf.sprintf "Word32 %s: expected [%s], got [%s]" description
      (String.concat "; " (List.map show_pair expected))
      (String.concat "; " (List.map show_pair actual)))

let test_division () =
  expect_division "zero dividend" ~dividend:0 ~divisor:7 [(0, 0)];
  expect_division "division by one" ~dividend:7 ~divisor:1 [(7, 0)];
  expect_division "dividend smaller than divisor" ~dividend:7 ~divisor:9 [(0, 7)];
  expect_division "quotient with a remainder" ~dividend:17 ~divisor:5 [(3, 2)];
  expect_division "maximum divided by two" ~dividend:0xffff_ffff ~divisor:2 [(0x7fff_ffff, 1)];
  expect_division "divisor with the top bit set" ~dividend:0xffff_ffff ~divisor:0x8000_0000 [(1, 0x7fff_ffff)];
  expect_division "divisor above the midpoint" ~dividend:0xffff_ffff ~divisor:0x8000_0001 [(1, 0x7fff_fffe)];
  expect_division "neighbouring large words" ~dividend:0xffff_ffff ~divisor:0xffff_fffe [(1, 1)];
  expect_division "equal maximum words" ~dividend:0xffff_ffff ~divisor:0xffff_ffff [(1, 0)];
  expect_division "zero divided by zero has no solution" ~dividend:0 ~divisor:0 [];
  expect_division "nonzero divided by zero has no solution" ~dividend:7 ~divisor:0 [];
  Printf.printf "Word32 division: quotient, remainder, unsigned boundaries and zero divisor OK\n%!"

let test_division_backwards () =
  expect_words "recover dividend from 5 * 3 + 2" [17] (fun dividend ->
    Word32.divmodo dividend (Word32.word 5) (Word32.word 3) (Word32.word 2));
  expect_words "recover divisor from 17 = divisor * 3 + 2" [5] (fun divisor ->
    Word32.divmodo (Word32.word 17) divisor (Word32.word 3) (Word32.word 2));
  expect_words "recover maximum divisor" [0xffff_ffff] (fun divisor ->
    Word32.divmodo (Word32.word 0xffff_ffff) divisor (Word32.word 1) (Word32.word 0));
  expect_words "remainder must be smaller than the divisor" [] (fun dividend ->
    Word32.divmodo dividend (Word32.word 5) (Word32.word 3) (Word32.word 5));
  Printf.printf "Word32 inverse division: either operand and impossible remainder OK\n%!"

let test_invalid_widths () =
  List.iter (fun count ->
    let malformed = Std.list inj (List.init count (fun _ -> false)) in
    List.iter (fun operation ->
      expect_words "invalid left width" [] (operation malformed (Word32.word 0));
      expect_words "invalid right width" [] (operation (Word32.word 0) malformed);
      expect_words "invalid result width" [] (fun left ->
        ocanren { left == !(Word32.word 0) & operation left !(Word32.word 0) malformed })
    ) [Word32.addo; Word32.subo; Word32.mulo];
    List.iter (fun relation ->
      let left = Stream.take @@ run q (relation malformed (Word32.word 0))
        (fun answer -> answer#reify Std.Bool.prj_exn) in
      let right = Stream.take @@ run q (relation (Word32.word 0) malformed)
        (fun answer -> answer#reify Std.Bool.prj_exn) in
      assert (left = [] && right = [])
    ) [Word32.lto; Word32.gto; Word32.eqo];
    let malformed_nonzero = Std.list inj (List.init count (fun index -> index = 0)) in
    expect_words "invalid dividend width" [] (fun quotient ->
      Word32.divmodo malformed (Word32.word 1) quotient (Word32.word 0));
    expect_words "invalid nonzero divisor width" [] (fun quotient ->
      Word32.divmodo (Word32.word 0) malformed_nonzero quotient (Word32.word 0));
    expect_words "invalid quotient width" [] (fun remainder ->
      Word32.divmodo (Word32.word 0) (Word32.word 1) malformed remainder);
    expect_words "invalid remainder width" [] (fun quotient ->
      Word32.divmodo (Word32.word 0) (Word32.word 1) quotient malformed);
    let naturals = Stream.take @@ run q (Word32.to_nato malformed)
      (fun answer -> answer#reify Std.Nat.reify) in
    assert (naturals = [])
  ) [0; 31; 33];
  Printf.printf "Word32 relations reject malformed widths: OK\n%!"

let run_tests () =
  test_conversions ();
  test_reifiers ();
  test_nat ();
  test_arithmetic ();
  test_backwards ();
  test_comparisons ();
  test_comparisons_backwards ();
  test_division ();
  test_division_backwards ();
  test_invalid_widths ()
