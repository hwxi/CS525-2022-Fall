(* ****** ****** *)
(*
Due: Monday, the 3rd of October
*)
(* ****** ****** *)
(*
HX-2022-09-28:
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
fun
TMadd // addition
(x: term, y: term): term =
TMopr("+", mylist_pair(x, y))
(* ****** ****** *)

fun
church_numeral(n: int): term =
let
  val f = TMvar("f")
  val x = TMvar("x")
in//let
TMlam("f", TMlam("x", loop(n, x))) where
{
fun
loop
(n: int, res: term): term =
if n > 0 then loop(n-1, TMapp(f, res)) else res
}
end // end of [church_numeral]

(* ****** ****** *)

fun
church_numeral_eval(n: term): term =
term_interp(TMapp(TMapp(n, f), x)) where
{
val x = TMint(0)
val f = TMlam("n", TMadd(TMvar("n"), TMint(1)))
}

(* ****** ****** *)
//
// 10 points
//
extern
fun
church_numeral_add(m: term, n: term): term // m+n
//
(* ****** ****** *)
//
// 10 points
//
extern
fun
church_numeral_mul(m: term, n: term): term // m*n
//
(* ****** ****** *)
//
// 10 points
//
extern
fun
church_numeral_pow(m: term, n: term): term // m^n
//
(* ****** ****** *)

val () =
println
(
"church_numeral_add(2, 10) = ",
church_numeral_eval(church_numeral_add(church_numeral(2), church_numeral(10))))

(* ****** ****** *)

val () =
println
(
"church_numeral_mul(2, 10) = ",
church_numeral_eval(church_numeral_mul(church_numeral(2), church_numeral(10))))

(* ****** ****** *)

val () =
println
(
"church_numeral_pow(2, 10) = ",
church_numeral_eval(church_numeral_pow(church_numeral(2), church_numeral(10))))

(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign03.dats] *)
