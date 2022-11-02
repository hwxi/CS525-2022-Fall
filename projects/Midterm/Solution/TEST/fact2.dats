(* ****** ****** *)

fun
fact(x) =
let
  fun
  loop
  ( xr
  : (int,int)): int =
  let
    val x = fst(xr)
    val r = snd(xr)
  in
    if x > 0 then loop(x-1, x*r) else r
  end
in
  loop(x, 1)
end

(* ****** ****** *)

fun main() =
(
print("fact(10) = "); print(fact(10))
)

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_fact2.dats] *)
