(* ****** ****** *)
(*
For testing type-checker
*)
(* ****** ****** *)
(*
val
omega =
lam x => x(x)
val
Omega = omega(omega)
*)
(* ****** ****** *)

val I = lam x => x
val K = lam x => lam y => x
val K' = lam x => lam y => y
val S = lam x => lam y => lam z => x(z)(y(z))

(* ****** ****** *)

(* end of [nators.dats] *)
