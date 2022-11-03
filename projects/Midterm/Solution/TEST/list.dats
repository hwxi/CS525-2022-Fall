(* ****** ****** *)

fun
length(xs: list(int)): int =
if
list_nilq(xs)
then 0 else 1+length(list_uncons2(xs))

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_list.dats] *)
