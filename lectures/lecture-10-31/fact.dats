(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)

fun fact(x: int): int =
if x > 0 then x * fact(x-1) else 1

(* ****** ****** *)

(* end of [lectures/lecture-10-31/fact.dats] *)
