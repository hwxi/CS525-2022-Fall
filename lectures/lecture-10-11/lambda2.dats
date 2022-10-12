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
tVar_new(): tVar
(* ****** ****** *)
extern
fun
type_new_ext(): type
extern
fun
type_new_fun(): type
extern
fun
type_new_tup(): type
(* ****** ****** *)
implement
tVar_new() =
ref(myoptn_nil())
(* ****** ****** *)
implement
type_new_ext() =
TPext(tVar_new())
implement
type_new_fun() =
TPfun
(type_new_ext(), type_new_ext())
implement
type_new_tup() =
TPtup
(type_new_ext(), type_new_ext())
(* ****** ****** *)
extern
fun
type_eval(type): type
(* ****** ****** *)
implement
type_eval(tp0) =
(
case+ tp0 of
|
TPext(X0) =>
(
case+ !X0 of
|
myoptn_nil() => tp0
|
myoptn_cons(tp1) =>
let
val tp1 =
type_eval(tp1) in tp1
end
)
| _ (*non-TPext*) => tp0
)
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
(tp1: type, tp2: type): bool
overload unify with type_unify
//
extern
fun
type_unify_var1
(X1: tVar, tp2: type): bool
extern
fun
type_unify_var2
(tp1: type, X2: tVar): bool
//
(* ****** ****** *)

implement
type_unify
(tp1, tp2) =
let
val tp1 = type_eval(tp1)
val tp2 = type_eval(tp2)
in//let
case
(tp1, tp2) of
|
(TPext(X1), _) => type_unify_var1(X1, tp2)
|
(_, TPext(X2)) => type_unify_var2(tp1, X2)
|
(TPbas nm1, TPbas nm2) => (nm1 = nm2)
|
(TPfun(tp11, tp12), TPfun(tp21, tp22)) =>
(type_unify(tp11, tp21) && type_unify(tp12, tp22))
|
(TPtup(tp11, tp12), TPtup(tp21, tp22)) =>
(type_unify(tp11, tp21) && type_unify(tp12, tp22))
| (_, _) => false
end // end of [let]

(* ****** ****** *)

extern
fun
tVar_equal_ref
(X1: tVar, X2: tVar): bool
overload == with tVar_equal_ref

(* ****** ****** *)

implement
tVar_equal_ref
(X1, X2) =
(ref_get_ptr(X1) = ref_get_ptr(X2))

(* ****** ****** *)

extern
fun
tVar_occurs_type
(X1: tVar, tp2: type): bool

(* ****** ****** *)

implement
type_unify_var1
(X1, tp2) =
// HX-2022-10-12:
// [tp2] is already evaluated!
(
case+ tp2 of
|
TPext(X2) =>
if
X1 == X2
then true
else (!X1 := myoptn_cons(tp2); true)
| _ =>
if
tVar_occurs_type(X1, tp2)
// X1 is contained in tp2
then false else (!X1 := myoptn_cons(tp2); true)
)

implement
type_unify_var2
(tp1, X2) =
(
if
tVar_occurs_type(X2, tp1)
// X2 is contained in tp1
then false else (!X2 := myoptn_cons(tp1); true)
)

(* ****** ****** *)

implement
tVar_occurs_type
(X1, tp2) =
let
val tp2 = type_eval(tp2)
in
case+ tp2 of
| TPbas _ => false
| TPext(X2) => (X1 == X2)
| TPfun(tp21, tp22) =>
  (tVar_occurs_type(X1, tp21) || tVar_occurs_type(X1, tp22))
| TPtup(tp21, tp22) =>
  (tVar_occurs_type(X1, tp21) || tVar_occurs_type(X1, tp22))
end

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
//
implement
term_oftype1
(  t0, xts  ) =
(
case+ t0 of
//
| TMint _ => TPint
| TMbtf _ => TPbtf
| TMstr _ => TPstr
//
| TMvar _ =>
term_oftype1_var(t0, xts)
//
|
TMlam(x1, t1) =>
let
val tp1 = type_new_ext()
in//let
(
  TPfun(tp1, tp2) ) where
{
val tp2 =
term_oftype1
(t1, mylist_cons(@(x1, tp1), xts)) }
end
//
|
TMapp(t1, t2) =>
let
val tp1 =
term_oftype1(t1, xts)
val tp2 =
term_oftype1(t2, xts)
//
val tp1 =
let
  val tp1 =
  type_eval(tp1)
in
  case+ tp1 of
  |
  TPext X1 =>
  let
  val tp1 =
  type_new_fun()
  in
  !X1 :=
  myoptn_cons(tp1); tp1
  end
  | _ (*non-TPext*) => tp1
end : type // end-val
//
val-
TPfun(tp11, tp12) = tp1
//
val-true = unify(tp11, tp2) in tp12
end // let // end of [TPapp(t1, t2)]
//
|
TMif0(t1, t2, t3) =>
let
val tp1 =
term_oftype1(t1, xts)
val tp2 =
term_oftype1(t2, xts)
val tp3 =
term_oftype1(t3, xts)
val-true =
type_unify(tp1, TPbtf)
val-true = type_unify(tp2, tp3) in tp2 end
//
)
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-11/lambda2.dats] *)
