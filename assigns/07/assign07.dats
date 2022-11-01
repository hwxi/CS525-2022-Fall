(* ****** ****** *)
(*
Due: Wednesday, the 2nd of November
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
//
typedef ans = void
//
typedef
kont
(res:t@ype) =
(res) -<cloref1> ans
//
(* ****** ****** *)

fun
fact(n: int): int =
if n > 0 then n * fact(n-1) else 1

(* ****** ****** *)

fun
kfact
(n: int, k: kont(int)): ans =
if n > 0 then
kfact(n-1, lam(res) => k(n * res)) else k(1)

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [assigns/assign07.dats] *)
