(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)

typedef ans = int

fun kfact
(x: int, k: int -<cloref1> ans): int =
if x > 0 then kfact(x-1, lam(res) => k(x * res)) else k(k(1))

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

val kfact5 =
kfact(5, lam(res) => res)
val () = println!("kfact5 = ", kfact5)

(* ****** ****** *)

(* end of [lectures/lecture-10-31/fact.dats] *)
