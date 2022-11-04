(* ****** ****** *)

fun
length(xs: list(int)): int =
if
list_nilq(xs)
then 0 else 1+length(list_uncons2(xs))

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
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_list.dats] *)
