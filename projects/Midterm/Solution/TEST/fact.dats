(* ****** ****** *)

val fact =
fix
f(x: int): int =>
if x > 0 then x * f(x-1) else 1

(* ****** ****** *)

fun main() =
(
print("fact(10) = "); print(fact(10))
)

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_fact.dats] *)
