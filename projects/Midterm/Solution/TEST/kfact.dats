(* ****** ****** *)

fun
kfact(nk) =
let
  val n = fst(nk)
  val k = snd(nk)
in
  if n > 0
  then
  kfact(n-1, lam(r) => k(n * r))
  else k(1)
end

val fact =
lam(n) => kfact(n, lam r => r)

fun main() =
(
print("fact(10) = "); print(fact(10))
)

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_kfact.dats] *)
