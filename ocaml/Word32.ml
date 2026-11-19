open GT
open OCanren

@type t = bool list with show
@type logic = Std.Bool.logic Std.List.logic with show
type injected = bool ilogic Std.List.groundi

let width = 32
let max_value = 0xffff_ffff

let of_int value : t =
  List.init width (fun index -> ((value lsr index) land 1) <> 0)

let to_int (bits : t) =
  if List.length bits <> width then invalid_arg "Word32.to_int: expected 32 bits";
  List.fold_right (fun bit value -> (value lsl 1) lor (if bit then 1 else 0)) bits 0

let inj (bits : t) : injected =
  ignore (to_int bits);
  Std.list OCanren.inj bits

let word value = inj (of_int value)

let prj_exn =
  Reifier.fmap
    (fun bits -> ignore (to_int bits); bits)
    (Std.List.prj_exn Std.Bool.prj_exn)

let reify = Std.List.reify Std.Bool.reify

let of_nat natural =
  let rec collect value = function
    | Std.Nat.O -> of_int value
    | Std.Nat.S rest ->
        if value = max_value then invalid_arg "Word32.of_nat: out of range";
        collect (value + 1) rest
  in
  collect 0 natural

let to_nat bits = Std.Nat.of_int (to_int bits)

let full_addero carry left right sum next_carry =
  ocanren {
    carry == false & left == false & right == false & sum == false & next_carry == false |
    carry == false & left == false & right == true  & sum == true  & next_carry == false |
    carry == false & left == true  & right == false & sum == true  & next_carry == false |
    carry == false & left == true  & right == true  & sum == false & next_carry == true  |
    carry == true  & left == false & right == false & sum == true  & next_carry == false |
    carry == true  & left == false & right == true  & sum == false & next_carry == true  |
    carry == true  & left == true  & right == false & sum == false & next_carry == true  |
    carry == true  & left == true  & right == true  & sum == true  & next_carry == true
  }

let rec add_bitso count carry left right sum =
  if count = 0 then ocanren { left == [] & right == [] & sum == [] }
  else ocanren {
    fresh left_bit, left_tail, right_bit, right_tail, sum_bit, sum_tail, next_carry in
      left == left_bit :: left_tail &
      right == right_bit :: right_tail &
      sum == sum_bit :: sum_tail &
      full_addero carry left_bit right_bit sum_bit next_carry &
      add_bitso !(count - 1) next_carry left_tail right_tail sum_tail
  }

let addo left right sum =
  add_bitso width (OCanren.inj false) left right sum

let subo left right difference = addo right difference left

let rec halveo natural half odd =
  ocanren {
    natural == 0 & half == 0 & odd == false |
    natural == 1 & half == 0 & odd == true |
    fresh rest, half_rest in
      natural == Std.Nat.s (Std.Nat.s rest) &
      half == Std.Nat.s half_rest &
      halveo rest half_rest odd
  }

let wordo (bits : injected) = Std.List.lengtho bits (Std.nat width)

let rec sum_productso left right total sum =
  ocanren {
    left == [] & right == [] & sum == total |
    fresh left_bit, left_tail, right_bit, right_tail, next_total in
      left == left_bit :: left_tail &
      right == right_bit :: right_tail &
      {left_bit == false & next_total == total |
       left_bit == true & right_bit == false & next_total == total |
       left_bit == true & right_bit == true & next_total == Std.Nat.s total} &
      sum_productso left_tail right_tail next_total sum
  }

let rec mul_bitso left right left_prefix right_prefix carry product =
  ocanren {
    left == [] & right == [] & product == [] |
    fresh left_bit, left_tail, right_bit, right_tail, product_bit, product_tail,
          next_left_prefix, next_right_prefix, total, next_carry in
      left == left_bit :: left_tail &
      right == right_bit :: right_tail &
      product == product_bit :: product_tail &
      {left_bit == false | left_bit == true} &
      {right_bit == false | right_bit == true} &
      next_left_prefix == left_bit :: left_prefix &
      Std.List.appendo right_prefix [right_bit] next_right_prefix &
      sum_productso next_left_prefix next_right_prefix carry total &
      halveo total next_carry product_bit &
      mul_bitso left_tail right_tail next_left_prefix next_right_prefix next_carry product_tail
  }

let mulo left right product =
  ocanren {
    wordo left & wordo right & wordo product &
    mul_bitso left right [] [] 0 product
  }

let rec nat_bitso from_nat count natural bits =
  if count = 0 then ocanren { natural == 0 & bits == [] }
  else Fresh.three (fun bit tail half ->
    (bits === Std.List.cons bit tail) &&&
    (if from_nat then
       halveo natural half bit &&& nat_bitso from_nat (count - 1) half tail
     else
       nat_bitso from_nat (count - 1) half tail &&& halveo natural half bit))

let from_nato natural bits = nat_bitso true width natural bits

let to_nato bits natural = nat_bitso false width natural bits
