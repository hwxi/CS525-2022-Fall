(* ****** ****** *)
%{^
#include <math.h>
%}
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)

extern
fun
sqrt
(x: double): double = "mac#sqrt"

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

val () = println!("sqrt(2.0) = ", sqrt(2.0))

(* ****** ****** *)

(* end of [lectures/lecture-10-31/sqrt.dats] *)
