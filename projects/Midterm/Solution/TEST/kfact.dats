(* ****** ****** *)

fun
kfact(nk) =
let
  val n = fst(nk)
  val k = snd(nk)
in//let
if n > 0
then
kfact(n-1, lam(r) => k(n * r))
else k(1)
end (*let*) // end of [kfact(nk)]

(* ****** ****** *)

val fact =
(lam(n) => kfact(n, lam r => r))

(* ****** ****** *)

val _ =
(
print("fact(10) = "); print(fact(10)); print("\n")
)

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_TEST_kfact.dats] *)
