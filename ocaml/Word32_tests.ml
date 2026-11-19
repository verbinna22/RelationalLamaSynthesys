open OCanren

let expect_words description expected goal =
  let actual = Stream.take @@ run q goal (fun answer ->
    Word32.to_int (answer#reify Word32.prj_exn)) in
  if List.sort compare actual <> List.sort compare expected then
    failwith (Printf.sprintf "Word32 %s: expected [%s], got [%s]" description
      (String.concat "; " (List.map string_of_int expected))
      (String.concat "; " (List.map string_of_int actual)))

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

let test_invalid_widths () =
  List.iter (fun count ->
    let malformed = Std.list inj (List.init count (fun _ -> false)) in
    List.iter (fun operation ->
      expect_words "invalid left width" [] (operation malformed (Word32.word 0));
      expect_words "invalid right width" [] (operation (Word32.word 0) malformed);
      expect_words "invalid result width" [] (fun left ->
        ocanren { left == !(Word32.word 0) & operation left !(Word32.word 0) malformed })
    ) [Word32.addo; Word32.subo; Word32.mulo];
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
  test_invalid_widths ()
