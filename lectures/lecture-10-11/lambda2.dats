(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../../mylib/mylib.dats"
(* ****** ****** *)
implement
main0 = lam () => ()
(* ****** ****** *)
//
typedef tbas = string
//
(* ****** ****** *)
//
datatype type =
//
|
TPbas of tbas
|
TPext of tVar
|
TPfun of (type, type)
|
TPtup of (type, type)
//
where
tVar =
ref(myoptn(type))
and
typelst = mylist(type)
//
(* ****** ****** *)
val TPint = TPbas("int")
val TPbtf = TPbas("bool")
val TPstr = TPbas("string")
(* ****** ****** *)
extern
fun
print_type(type): void
extern
fun
fprint_type
(out:FILEref, tp:type): void
(* ****** ****** *)
implement
print_type(tp) =
fprint_type(stdout_ref, tp)
(* ****** ****** *)
implement
fprint_val<type> = fprint_type
(* ****** ****** *)
overload print with print_type
overload fprint with fprint_type
(* ****** ****** *)
implement
fprint_type
(out, tp) =
(
case+ tp of
|
TPbas(nm) =>
fprint!(out, "TPbas(", nm, ")")
|
TPext(X0) =>
fprint!(out, "TPext(", !X0, ")")
|
TPfun(tp1, tp2) =>
fprint!(out, "TPfun(", tp1, ";", tp2, ")")
|
TPtup(tp1, tp2) =>
fprint!(out, "TPtup(", tp1, ";", tp2, ")")
)
(* ****** ****** *)
//
extern
fun
type_unify
(t1: type, t2: type): bool
overload unify with type_unify
//
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
| TMint of int
| TMbtf of bool
| TMstr of string
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
| TMfix of
  (tvar(*f*), tvar(*x*), term)
//
| TMlam2 of
  (tvar, type, term)
| TMfix2 of
  (tvar(*f*), tvar(*x*), type, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)

typedef tctx = mylist(@(tvar, type))

(* ****** ****** *)
//
extern
fun
term_oftype0(term): type
extern
fun
term_oftype1(term, tctx): type
extern
fun
term_oftype1_var(term, tctx): type
extern
fun
term_oftype1_opr(term, tctx): type
//
extern
fun
termlst_oftype1
(ts: termlst, xts: tctx): typelst
//
(* ****** ****** *)

implement
term_oftype0(t0) =
term_oftype1( t0, mylist_nil())

(* ****** ****** *)

implement
term_oftype1
(  t0, xts  ) =
(
case- t0 of
| TMint _ => TPint
| TMbtf _ => TPbtf
| TMstr _ => TPstr
| TMvar _ => term_oftype1_var(t0, xts)
)
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-11/lambda2.dats] *)
