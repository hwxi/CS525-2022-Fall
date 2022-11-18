(* ****** ****** *)
//
fun
foldr(arg) =
let
val xs = fst(arg)
val r0 = fst(snd(arg))
val f0 = snd(snd(arg))
in
if
list_nilq(xs) then r0 else
f0(list_uncons1(xs), foldr(list_uncons2(xs), r0, f0))
end
//
(* ****** ****** *)
//
val xs = list_nil()
val xs = list_cons(3, xs)
val xs = list_cons(2, xs)
val xs = list_cons(1, xs)
//
val ys =
foldr
(xs, list_nil(), lam(xr) =>
list_cons(let val x = fst(xr) in x * x end, snd(xr)))
//
val _1_ =
(print("xs = "); print(xs); print("\n"))
//
val _2_ =
(print("ys = "); print(ys); print("\n"))
//
(*
xs = T1Vcons(1;T1Vint(1); T1Vcons(1;T1Vint(2); T1Vcons(1;T1Vint(3); T1Vcons(0;))))
ys = T1Vcons(1;T1Vint(1); T1Vcons(1;T1Vint(4); T1Vcons(1;T1Vint(9); T1Vcons(0;))))
*)
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_list_foldr.dats] *)
