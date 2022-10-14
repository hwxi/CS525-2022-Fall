(* ****** ****** *)
(*
Due: Monday, the 19th of October
*)
(* ****** ****** *)
(*
HX-2022-10-14: (50 points)
You can find an implementation of LAMBDA
in lambdas/lambda2.dats. Note that this
implementation is incomplete (there is no
handling of tuples). Please copy the code
to your own directory (MySolution) and then
complete the implementation.
*)
(* ****** ****** *)
//
(*
HX-2022-10-14: (20 points)
The function [isPrime] tests whether
a given natural number [n] is a prime.
Please implement [isPrime] in LAMBDA,
that is, construct a term in LAMBDA that
represents [isPrime]
*)
//
fun
isPrime
(n: int): bool =
loop( 2 ) where
{
fun
loop(i: int): bool =
if
(i*i > n)
then true
else (if n % i = 0 then false else loop(i+1))
}
//
(* ****** ****** *)
(*
HX-2022-10-14: (50 points)
Please encode in LAMBDA the implementation of the 8-queen puzzle
in the following page:
https://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x631.html
*)
(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign04.dats] *)
