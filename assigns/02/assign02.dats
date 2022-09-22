(* ****** ****** *)
(*
HX-2022-09-21:
This assignment asks you to implement
list-based set oprations.
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../mylib/mylib.dats"
(* ****** ****** *)
#include
"./../..\
/lectures/lecture-09-14/lambda0.dats"
(* ****** ****** *)
implement main() = 0 // HX: this is a dummy
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
| TMint of int
| TMbtf of bool
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)
//
fun
TMlt // less
(x: term, y: term): term =
TMopr("<", mylist_pair(x, y))
fun
TMlte // less-equal
(x: term, y: term): term =
TMopr("<=", mylist_pair(x, y))
//
fun
TMeq // equal
(x: term, y: term): term =
TMopr("=", mylist_pair(x, y))
fun
TMneq // not-equal
(x: term, y: term): term =
TMopr("!=", mylist_pair(x, y))
//
fun
TMadd // addition
(x: term, y: term): term =
TMopr("+", mylist_pair(x, y))
fun
TMsub // subtraction
(x: term, y: term): term =
TMopr("-", mylist_pair(x, y))
fun
TMmul // multiplication
(x: term, y: term): term =
TMopr("*", mylist_pair(x, y))
//
(* ****** ****** *)
//
// 05 points
val Y: term // the Y fixed-point operator
//
(* ****** ****** *)
//
// 05 points
(*
fact(x) = if x > 0 then x * fact(x-1) else 1
*)
val fact: term // representing the factorial function
//
(* ****** ****** *)
//
// 05 points
(*
fibo(x) = if x >= 2 then fibo(x-1)+fibo(x-2) else x
*)
val fibo: term // representing the Fibonacci function
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign02.dats] *)
