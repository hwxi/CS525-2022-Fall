(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../mylib/mylib.dats"
(* ****** ****** *)
implement
main0 = lam () => ()
(* ****** ****** *)
//
typedef tpbas = string
//
(* ****** ****** *)
//
datatype t1ype =
//
|
T1Pbas of tpbas
|
T1Pext of tpVar
|
T1Pfun of (t1ype, t1ype)
|
T1Ptup of (t1ype, t1ype)
//
where
tpVar =
ref(myoptn(t1ype))
and
t1ypelst = mylist(t1ype)
//
(* ****** ****** *)
val T1Pint = T1Pbas("int")
val T1Pbtf = T1Pbas("bool")
val T1Pchr = T1Pbas("char")
val T1Pnil = T1Pbas("unit")
val T1Pflt = T1Pbas("float")
val T1Pstr = T1Pbas("string")
(* ****** ****** *)
typedef tmvar = string
typedef tmopr = string
(* ****** ****** *)
//
datatype t1erm =
//
| T1Mnil of ()
//
| T1Mint of int
| T1Mbtf of bool
| T1Mstr of string
//
| T1Mvar of tmvar
| T1Mlam of (tmvar, t1erm)
| T1Mapp of (t1erm, t1erm)
//
| T1Mopr of (tmopr, t1ermlst)
//
| T1Mfst of (t1erm) // first projection
| T1Msnd of (t1erm) // second projection
| T1Mtup of (t1erm, t1erm) // pair formation
//
| T1Mif0 of (t1erm, t1erm, t1erm)
//
|
T1Mfix of
(tmvar(*f*), tmvar(*x*), t1erm)
//
|
T1Mlam2 of (tmvar, t1ype, t1erm)
|
T1Mfix2 of
(tmvar(*f*), tmvar(*x*), t1ype, t1erm)
//
where t1ermlst = mylist(t1erm)
//
(* ****** ****** *)
extern
fun
print_t1ype(t1ype): void
extern
fun
fprint_t1ype
(out:FILEref, tp0:t1ype): void
(* ****** ****** *)
extern
fun
print_t1erm(t1erm): void
extern
fun
fprint_t1erm
(out:FILEref, tm0:t1erm): void
(* ****** ****** *)
implement
print_t1ype(tp0) =
fprint_t1ype(stdout_ref, tp0)
(* ****** ****** *)
implement
fprint_val<t1ype> = fprint_t1ype
(* ****** ****** *)
overload print with print_t1ype
overload fprint with fprint_t1ype
(* ****** ****** *)
implement
print_t1erm(tm0) =
fprint_t1erm(stdout_ref, tm0)
(* ****** ****** *)
implement
fprint_val<t1erm> = fprint_t1erm
(* ****** ****** *)
overload print with print_t1erm
overload fprint with fprint_t1erm
(* ****** ****** *)
//
implement
fprint_t1ype
(out, tp0) =
(
case+ tp0 of
|
T1Pbas(nm) =>
fprint!(out, "T1Pbas(", nm, ")")
|
T1Pext(X0) =>
fprint!(out, "T1Pext(", !X0, ")")
|
T1Pfun(tp1, tp2) =>
fprint!(out, "T1Pfun(", tp1, ";", tp2, ")")
|
T1Ptup(tp1, tp2) =>
fprint!(out, "T1Ptup(", tp1, ";", tp2, ")")
)
//
(* ****** ****** *)
//
implement
fprint_t1erm
(out, tm0) =
(
case+ tm0 of
//
|
T1Mnil() =>
fprint!(out, "T1Mnil(", ")")
//
|
T1Mint(int) =>
fprint!(out, "T1Mint(", int, ")")
|
T1Mbtf(btf) =>
fprint!(out, "T1Mbtf(", btf, ")")
|
T1Mstr(str) =>
fprint!(out, "T1Mstr(", str, ")")
//
|
T1Mvar(tmv) =>
fprint!(out, "T1Mvar(", tmv, ")")
|
T1Mlam(xnm, tm1) =>
fprint!(out, "T1Mlam(", xnm, ";", tm1, ")")
|
T1Mapp(tm1, tm2) =>
fprint!(out, "T1Mapp(", tm1, ";", tm2, ")")
//
|
T1Mopr(opr, tms) =>
fprint!(out, "T1Mopr(", opr, ";", tms, ")")
//
|
T1Mfst(tm1) =>
fprint!(out, "T1Mfst(", tm1, ")")
|
T1Msnd(tm1) =>
fprint!(out, "T1Msnd(", tm1, ")")
|
T1Mtup(tm1, tm2) =>
fprint!(out, "T1Mtup(", tm1, ";", tm2, ")")
//
|
T1Mif0(tm1, tm2, tm3) =>
fprint!(out, "T1Mif0(", tm1, ";", tm2, ";", tm3, ")")
//
|
T1Mfix(fnm, xnm, tm1) =>
fprint!(out, "T1Mfix(", fnm, ";", xnm, ";", tm1, ")")
//
|
T1Mlam2(xnm, xtp, tm1) =>
fprint!(out, "T1Mlam(", xnm, ";", xtp, ";", tm1, ")")
|
T1Mfix2(fnm, ftp, xnm, tm1) =>
fprint!(out, "T1Mfix(", fnm, ";", ftp, ";", xnm, ";", tm1, ")")
//
) (*case+*) // end of [fprint_t1erm(out, tm0)]
//
(* ****** ****** *)

datatype t1val =
//
| T1Vnil of ()
//
| T1Vint of int
| T1Vbtf of bool
| T1Vstr of string
//
| T1Vtup of (t1val, t1val)
//
| T1Vlam of (t1erm, tvenv)
| T1Vfix of (t1erm, tvenv)
//
where
tvenv = mylist(@(tmvar, t1val))

typedef t1vallst = mylist(t1val)

(* ****** ****** *)
extern
fun
print_t1val(t1val): void
extern
fun
fprint_t1val
(out:FILEref, tv0:t1val): void
(* ****** ****** *)
implement
print_t1val(tv0) =
fprint_t1val(stdout_ref, tv0)
(* ****** ****** *)
implement
fprint_val<t1val> = fprint_t1val
(* ****** ****** *)
overload print with print_t1val
overload fprint with fprint_t1val
(* ****** ****** *)
implement
fprint_t1val
(out, tv0) =
(
case+ tv0 of
|
T1Vnil() =>
fprint!(out, "T1Vnil(", ")")
//
|
T1Vint(int) =>
fprint!(out, "T1Vint(", int, ")")
|
T1Vbtf(btf) =>
fprint!(out, "T1Vbtf(", btf, ")")
|
T1Vstr(str) =>
fprint!(out, "T1Vstr(", str, ")")
|
T1Vtup(tv1, tv2) =>
fprint!
(out, "T1Vtup(", tv1, ";", tv2, ")")
|
T1Vlam(tm0, env) =>
fprint!(out, "T1Vlam(", tm0, ";", "...", ")")
|
T1Vfix(tm0, env) =>
fprint!(out, "T1Vfix(", tm0, ";", "...", ")")
)
(* ****** ****** *)

extern
fun
t1erm_interp0(t1erm): t1val
extern
fun
t1erm_interp1
(tm0: t1erm, xvs: tvenv): t1val
extern
fun
t1erm_interp1_var
(tm0: t1erm, xvs: tvenv): t1val
extern
fun
t1erm_interp1_opr
(tm0: t1erm, xvs: tvenv): t1val
extern
fun
t1ermlst_interp1
(tms: t1ermlst, xvs: tvenv): t1vallst

(* ****** ****** *)

implement
t1erm_interp0(tm0) =
t1erm_interp1(tm0, mylist_nil())

implement
t1erm_interp1(tm0, xvs) =
(
case tm0 of
//
| T1Mnil() => T1Vnil()
//
| T1Mint(i0) => T1Vint(i0)
| T1Mbtf(b0) => T1Vbtf(b0)
| T1Mstr(s0) => T1Vstr(s0)
//
|
T1Mvar _ =>
t1erm_interp1_var(tm0, xvs)
//
|
T1Mlam _ => T1Vlam(tm0, xvs)
|
T1Mfix _ => T1Vfix(tm0, xvs)
//
|
T1Mapp(tm1, tm2) =>
let
val
tv1 = t1erm_interp1(tm1, xvs)
val
tv2 = t1erm_interp1(tm2, xvs)
in//let
case- tv1 of
|
T1Vlam(T1Mlam(xnm, tbd), xvs) =>
t1erm_interp1
(tbd, mylist_cons(@(xnm, tv2), xvs))
|
T1Vfix(T1Mfix(fnm, xnm, tbd), xvs) =>
t1erm_interp1
(tbd, mylist_cons(@(fnm, tv1), mylist_cons(@(xnm, tv2), xvs)))
end // let // end of [T1Mapp]
//
|
T1Mopr _ => t1erm_interp1_opr(tm0, xvs)
//
|
T1Mif0(tm1, tm2, tm3) =>
let
val tv1 = t1erm_interp1(tm1, xvs)
in//let
case- tv1 of
|
T1Vbtf(b1) =>
if b1 then t1erm_interp1(tm2, xvs)
      else t1erm_interp1(tm3, xvs)
end // let // end of [T1Mif0]
//
|
T1Mlam2
(xnm, tp1, tm1) => T1Vlam(T1Mlam(xnm, tm1), xvs)
|
T1Mfix2
(fnm, xnm, tp1, tm1) => T1Vfix(T1Mfix(fnm, xnm, tm1), xvs)
//
) (* case+ *) // end of [t1erm_interp1(tm0, xvs)]

(* ****** ****** *)

implement
t1ermlst_interp1(tms, xvs) =
(
case+ tms of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(tm1, tms) =>
mylist_cons
(t1erm_interp1(tm1, xvs), t1ermlst_interp1(tms, xvs))
)

(* ****** ****** *)

implement
t1erm_interp1_var
(tm0, xvs) =
let
val-T1Mvar(x) = tm0 
in
find(xvs) where
{
fun find(xvs: tvenv): t1val =
(
case- xvs of
| mylist_cons(xv1, xvs) =>
  (if x = xv1.0 then xv1.1 else find(xvs))
)
}
end (*let*) // end of [t1erm_interp1_var]

(* ****** ****** *)

implement
t1erm_interp1_opr
  (tm0, xvs) =
let
//
val-
T1Mopr(opr, tms) = tm0
val tvs = t1ermlst_interp1(tms, xvs)
//
in//let
(
case- opr of
//
| "+" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1+i2)
end
| "-" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1-i2)
end
| "*" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1*i2)
end
//
| "<" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 < i2)
end
| ">" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 > i2)
end
| "=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 = i2)
end
| "<=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 <= i2)
end
| ">=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 >= i2)
end
| "!=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 != i2)
end
//
| "show" =>
let
val-
mylist_cons(tv1, tvs) = tvs
in
  case- tv1 of
  | T1Vstr(str) => let val () = print(str) in T1Vnil() end
end
//
| "showval" =>
let
val-mylist_cons(tv1, tvs) = tvs in print(tv1); T1Vnil() end
//
)
end (*let*) // end of [t1erm_interp_opr(tm0, xvs)]

(* ****** ****** *)
//
fun
T1Madd // addition
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("+", mylist_pair(a1, a2))
fun
T1Msub // subtraction
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("-", mylist_pair(a1, a2))
fun
T1Mmul // multiplication
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("*", mylist_pair(a1, a2))
//
fun
T1Mlt // less
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("<", mylist_pair(a1, a2))
fun
T1Mgt // greater
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr(">", mylist_pair(a1, a2))
fun
T1Mlte // less-equal
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("<=", mylist_pair(a1, a2))
fun
T1Mgte // greater-equal
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr(">=", mylist_pair(a1, a2))
//
fun
T1Meq // equal
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("=", mylist_pair(a1, a2))
fun
T1Mneq // not-equal
(a1: t1erm, a2: t1erm): t1erm =
T1Mopr("!=", mylist_pair(a1, a2))
//
(* ****** ****** *)
//
fun
Theta() =
T1Mapp(wxy, wxy) where
{
//
val x = T1Mvar("x")
val y = T1Mvar("y")
val z = T1Mvar("z")
//
val wxy =
T1Mlam("x", T1Mlam("y",
T1Mapp(y,
T1Mlam("z", T1Mapp(T1Mapp(T1Mapp(x, x), y), z)))))
//
}(*where*)//end-of-[fun Theta()]
//
val
mysum =
T1Mapp
(
Theta(),
(
T1Mlam("f",
T1Mlam("n",
T1Mif0(
T1Mgt(n, T1Mint(0)),
T1Madd(n, T1Mapp(f, T1Msub(n, T1Mint(1)))), T1Mint(0))))) where
{
  val f = T1Mvar("f")
  val n = T1Mvar("n")
}
)
//
val () =
println!("mysum(100) = ", t1erm_interp0(T1Mapp(mysum, T1Mint(100))))
//
(* ****** ****** *)
extern
fun
tpVar_new(): tpVar
(* ****** ****** *)
extern
fun
t1ype_new_ext(): t1ype
extern
fun
t1ype_new_fun(): t1ype
extern
fun
t1ype_new_tup(): t1ype
(* ****** ****** *)
extern
fun
t1ype_eval(t1ype): t1ype
(* ****** ****** *)
implement
tpVar_new() =
ref(myoptn_nil())
(* ****** ****** *)
//
implement
t1ype_new_ext() =
T1Pext(tpVar_new())
//
implement
t1ype_new_fun() =
T1Pfun
(t1ype_new_ext(), t1ype_new_ext())
//
implement
t1ype_new_tup() =
T1Ptup
(t1ype_new_ext(), t1ype_new_ext())
//
(* ****** ****** *)
implement
t1ype_eval(tp0) =
(
case+ tp0 of
|
T1Pext(X0) =>
(
case+ !X0 of
|
myoptn_nil() => tp0
|
myoptn_cons(tp1) => t1ype_eval(tp1)
)
| _ (*non-T1Pext*) => tp0
)
(* ****** ****** *)
//
extern
fun
tpVar_equal_ref
(X1: tpVar, X2: tpVar): bool
overload == with tpVar_equal_ref
//
implement
tpVar_equal_ref
(X1, X2) =
(ref_get_ptr(X1) = ref_get_ptr(X2))
//
(* ****** ****** *)

extern
fun
tpVar_occurs_t1ype
(X1: tpVar, tp2: t1ype): bool

(* ****** ****** *)
//
extern
fun
t1ype_unify
(tp1: t1ype, tp2: t1ype): bool
overload unify with t1ype_unify
//
extern
fun
t1ype_unify_var1(tpVar, t1ype): bool
extern
fun
t1ype_unify_var2(t1ype, tpVar): bool
//
(* ****** ****** *)

implement
tpVar_occurs_t1ype
(X1, tp2) =
let
val tp2 = t1ype_eval(tp2)
in
case+ tp2 of
|
T1Pbas _ => false
|
T1Pext(X2) => (X1 == X2)
|
T1Pfun(tp21, tp22) =>
(tpVar_occurs_t1ype(X1, tp21) || tpVar_occurs_t1ype(X1, tp22))
|
T1Ptup(tp21, tp22) =>
(tpVar_occurs_t1ype(X1, tp21) || tpVar_occurs_t1ype(X1, tp22))
end // end of [let] // end of [tpVar_occurs_t1ype]

(* ****** ****** *)
//
implement
t1ype_unify
(tp1, tp2) =
let
val tp1 = t1ype_eval(tp1)
val tp2 = t1ype_eval(tp2)
in//let
case
(tp1, tp2) of
|
(T1Pext(X1), _) => t1ype_unify_var1(X1, tp2)
|
(_, T1Pext(X2)) => t1ype_unify_var2(tp1, X2)
|
(T1Pbas nm1, T1Pbas nm2) => (nm1 = nm2)
|
(T1Pfun(tp11, tp12), T1Pfun(tp21, tp22)) =>
(t1ype_unify(tp11, tp21) && t1ype_unify(tp12, tp22))
|
(T1Ptup(tp11, tp12), T1Ptup(tp21, tp22)) =>
(t1ype_unify(tp11, tp21) && t1ype_unify(tp12, tp22))
| (_, _) => false // HX: covering the rest of cases
end // end of [let] // end of [t1ype_unify(tp1, tp2)]
//
(* ****** ****** *)
//
implement
t1ype_unify_var1
(X1, tp2) =
// HX-2022-10-12:
// [tp2] is already evaluated!
(
case+ tp2 of
|
T1Pext(X2) =>
if
X1 == X2
then true
else (!X1 := myoptn_cons(tp2); true)
| _ =>
if
tpVar_occurs_t1ype(X1, tp2)
// X1 is contained in tp2
then false else (!X1 := myoptn_cons(tp2); true)
)
//
implement
t1ype_unify_var2
(tp1, X2) =
(
if
tpVar_occurs_t1ype(X2, tp1)
// X2 is contained in tp1
then false else (!X2 := myoptn_cons(tp1); true)
)
//
(* ****** ****** *)

typedef
tpctx =
mylist(@(tmvar, t1ype))

(* ****** ****** *)
//
extern
fun
t1erm_oftype0(t1erm): t1ype
extern
fun
t1erm_oftype1(t1erm, tpctx): t1ype
//
extern
fun
t1ermlst_oftype1
(tms: t1ermlst, xts: tpctx): t1ypelst
//
extern
fun
t1erm_oftype1_var(t1erm, tpctx): t1ype
extern
fun
t1erm_oftype1_opr(t1erm, tpctx): t1ype
//
(* ****** ****** *)

implement
t1erm_oftype0(tm0) =
t1erm_oftype1( tm0, mylist_nil())

(* ****** ****** *)
//
implement
t1erm_oftype1
(  tm0, xts  ) =
(
case tm0 of
//
| T1Mnil _ => T1Pnil
//
| T1Mint _ => T1Pint
| T1Mbtf _ => T1Pbtf
| T1Mstr _ => T1Pstr
//
| T1Mvar _ =>
t1erm_oftype1_var(tm0, xts)
//
|
T1Mlam(x1, tm1) =>
let
val tp1 = t1ype_new_ext()
in//let
(
  T1Pfun(tp1, tp2) ) where
{
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(x1, tp1), xts)) }
end
//
|
T1Mfix
(fnm, x1, tm1) =>
(
  tp1 ) where
{
val
tp1 = t1ype_new_fun()
val-
T1Pfun(tp11, tp12) = tp1
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(x1, tp11), xts)))
val-true = t1ype_unify(tp12, tp2)
}
//
|
T1Mapp(tm1, tm2) =>
let
val tp1 =
t1erm_oftype1(tm1, xts)
val tp2 =
t1erm_oftype1(tm2, xts)
//
val tp1 =
let
  val tp1 =
  t1ype_eval(tp1)
in
  case+ tp1 of
  |
  T1Pext X1 =>
  let
  val tp1 =
  t1ype_new_fun()
  in
  !X1 :=
  myoptn_cons(tp1); tp1
  end
  | _ (*non-T1Pext*) => tp1
end : t1ype // end-val
//
val-
T1Pfun(tp11, tp12) = tp1
//
val-true = t1ype_unify(tp11, tp2) in tp12
end // let // end of [T1Papp(tm1, t2)]
//
|
T1Mopr _ => t1erm_oftype1_opr(tm0, xts)
//
|
T1Mif0
(tm1, tm2, tm3) =>
let
val tp1 =
t1erm_oftype1(tm1, xts)
val tp2 =
t1erm_oftype1(tm2, xts)
val tp3 =
t1erm_oftype1(tm3, xts)
val-true =
t1ype_unify(tp1, T1Pbtf)
val-true = t1ype_unify(tp2, tp3) in tp2 end
//
|
T1Mlam2
(x1, tp1, tm1) =>
(
  T1Pfun(tp1, tp2) ) where
{
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(x1, tp1), xts)) }
//
|
T1Mfix2
(fnm, x1, tp1, tm1) =>
(
  tp1 ) where
{
val-
T1Pfun(tp11, tp12) = tp1
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(x1, tp11), xts)))
val-true = t1ype_unify(tp12, tp2)
}
//
) (*case+*) // end of [t1erm_oftype1]
//
(* ****** ****** *)
implement
t1ermlst_oftype1(tms, xts) =
(
case+ tms of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(tm1, tms) =>
mylist_cons
(t1erm_oftype1(tm1, xts), t1ermlst_oftype1(tms, xts))
)
(* ****** ****** *)
implement
t1erm_oftype1_var
(tm0, xts) =
let
val-T1Mvar(x) = tm0
in
find(xts) where
{
fun find(xts: tpctx): t1ype =
(
case- xts of
| mylist_cons(xt, xts) =>
  (if x = xt.0 then xt.1 else find(xts))
)
}
end (*let*) // end of [t1erm_oftype1_var(tm0,xts)]
(* ****** ****** *)
implement
t1erm_oftype1_opr
(tm0, xts) =
let
//
val-
T1Mopr(opr, tms) = tm0
val
tps = t1ermlst_oftype1(tms, xts)
//
in//let
(
case- opr of
//
| "+" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "-" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "*" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
//
| "<" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
| ">" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
| "=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
| "<=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
| ">=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
| "!=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbtf
end
//
)
end (*let*) // end of [t1erm_oftype1_opr(tm0, xts)]
(* ****** ****** *)
(*
val () =
println!("mysum: ", t1erm_oftype0(mysum))
*)
(* ****** ****** *)
//
val
mysum2 =
T1Mfix2("f", "n", T1Pfun(T1Pint, T1Pint),
T1Mif0(
T1Mgt(n, T1Mint(0)),
T1Madd(n, T1Mapp(f, T1Msub(n, T1Mint(1)))), T1Mint(0))) where
{
  val f = T1Mvar("f")
  val n = T1Mvar("n")
}
//
val () =
println!("mysum2: ", t1erm_oftype0(mysum2))
val () =
println!("mysum2(100) = ", t1erm_interp0(T1Mapp(mysum2, T1Mint(100))))
//
(* ****** ****** *)

(* end of [lambdas_lambda2.dats] *)
