(* ****** ****** *)
(*
Due: Monday, the 26th of September
*)
(* ****** ****** *)
(*
HX-2022-09-21:
This assignment asks you to implement
certain lambda-terms.
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../mylib/mylib.dats"
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
extern
fun
print_term(t0:term): void
extern
fun
fprint_term
(out:FILEref, t0:term): void
(* ****** ****** *)
implement
print_term(t0) =
fprint_term(stdout_ref, t0)
(* ****** ****** *)
implement
fprint_val<term> = fprint_term
(* ****** ****** *)
overload print with print_term
overload fprint with fprint_term
(* ****** ****** *)
//
implement
fprint_term
(out, t0) =
(
case+ t0 of
|
TMint(i0) =>
fprint!(out, "TMint(", i0, ")")
|
TMbtf(b0) =>
fprint!(out, "TMbtf(", b0, ")")
|
TMvar(v0) =>
fprint!(out, "TMvar(", v0, ")")
|
TMlam(v0, t1) =>
fprint!(out, "TMlam(", v0, ";", t1, ")")
|
TMapp(t1, t2) =>
fprint!(out, "TMapp(", t1, ";", t2, ")")
|
TMopr(nm, ts) =>
fprint!(out, "TMopr(", nm, ";", ts, ")")
|
TMif0(t1, t2, t3) =>
fprint!(out, "TMif0(", t1, ";", t2, ";", t3, ")")
)
//
(* ****** ****** *)
//
fun
TMlt // less
(x: term, y: term): term =
TMopr("<", mylist_pair(x, y))
fun
TMgt // greater
(x: term, y: term): term =
TMopr(">", mylist_pair(x, y))
fun
TMlte // less-equal
(x: term, y: term): term =
TMopr("<=", mylist_pair(x, y))
fun
TMgte // greater-equal
(x: term, y: term): term =
TMopr(">=", mylist_pair(x, y))
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
extern
fun Y(): term // the Y fixed-point operator
//
(* ****** ****** *)
//
// 05 points
(*
fact(x) = if x > 0 then x * fact(x-1) else 1
*)
extern
fun fact(): term // representing the factorial function
//
(* ****** ****** *)
//
// 05 points
(*
fibo(x) = if x >= 2 then fibo(x-1)+fibo(x-2) else x
*)
extern
fun fibo(): term // representing the Fibonacci function
//
(* ****** ****** *)

val () = println!("Y = ", Y())
val () = println!("fact = ", fact())
val () = println!("fibo = ", fibo())

(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign02.dats] *)
