(* ****** ****** *)
(*
Due: Wednesday, the 2nd of November
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
typedef int2 = @(int, int) // for int-pairs
(* ****** ****** *)
//
(*
Problem 1:
HX-2022-10-26: 10 points
Please implement a stream containing all of the pairs
of natural numbers: You need to give a brief argument
as to why your implementation is correct:
*)
extern
val theNat2s: stream(int2) // all of the pairs of nats
//
(* ****** ****** *)
//
(*
Problem 2
HX-2022-10-26: 20 points
Assume that 'f0' is a binary function in pairs of natural
numbers such that 'f0' is non-decreasing on either of its
arguments. For instance, f0(i, j) = i+j is such a function
but f0(i, j) = i - j is not.
Please implement a function 'stream_fenum2' that enumerates
*all* the possible values of 'f0' in an ascending order:
*)
extern
fun
stream_fenum2
(f0: (int, int) -> int): stream(int) // ascending order
//
(*
Say that N = f(i1, j1) = f(i2, j2) for some distinct pairs
(i1, j1) and (i2, j2); the value N should be enumerated once
for f(i1, j1) and once for f(i2, j2). In other words, it is
*incorrect* to enumerate N only once for both f(i1, j1) and
f(i2, j2).
*)
(* ****** ****** *)

(*
Problem 3:
HX-2022-10-26: 10 points
Call 'stream_fenum2' on lam(i, j) => (i+2)*(j+2) to generate
a stream (theCompounds) of compound numbers; then build a stream
(thePrimes) that enumerates all the natural numbers that are not
in the stream of compound numbers.
*)
extern
val thePrimes: stream(int)
extern
val theCompunds: stream(int)

(* ****** ****** *)

(* end of [assign06.dats] *)
