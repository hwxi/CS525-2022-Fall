(* ****** ****** *)

fun
length(xs: list(int)): int =
if
list_nilq(xs)
then 0 else 1+length(list_uncons2(xs))

(* ****** ****** *)
//
fun
square(xs: list(int)): int =
if
list_nilq(xs)
then list_nil()
else let
  val x1 = list_uncons1(xs)
  val xs = list_uncons2(xs)
in
  list_cons(x1 * x1, square(xs))
end
//
(* ****** ****** *)
//
val xs = list_nil()
val xs = list_cons(3, xs)
val xs = list_cons(2, xs)
val xs = list_cons(1, xs)
val _1_ =
(print("xs = "); print(xs); print("\n"))
val _2_ =
(print("|xs| = "); print(length(xs)); print("\n"))
//
val ys = square(xs)
val _3_ =
(print("ys = "); print(ys); print("\n"))
val _2_ =
(print("|ys| = "); print(length(ys)); print("\n"))
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_list.dats] *)
