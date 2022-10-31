(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)

fun f91(x: int): int =
if x > 100 then x - 10 else f91(f91(x+11))

(* ****** ****** *)

typedef ans = int

fun
kf91
(x: int, k: int -<cloref1> ans): int =
if x > 100
then k(x-10)
else kf91(x+11, lam(res) => kf91(res, k))

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

val () = println!("f91(23) = ", f91(23))
val () = println!("kf91(23) = ", kf91(23, lam(res) => res))

(* ****** ****** *)

(* end of [lectures/lecture-10-31/f91.dats] *)
