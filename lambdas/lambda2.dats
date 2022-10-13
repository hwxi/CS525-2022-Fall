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
typedef tmvar = string
typedef tmopr = string
(* ****** ****** *)
//
datatype t1erm =
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
| VALint of int
| VALbtf of bool
| VALstr of string
//
| VALlam of (t1erm, tvenv)
| VALfix of (t1erm, tvenv)
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
VALint(int) =>
fprint!(out, "VALint(", int, ")")
|
VALbtf(btf) =>
fprint!(out, "VALbtf(", btf, ")")
|
VALstr(str) =>
fprint!(out, "VALstr(", str, ")")
|
VALlam(tm0, env) =>
fprint!(out, "VALlam(", "...", ")")
|
VALfix(tm0, env) =>
fprint!(out, "VALfix(", "...", ")")
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

(* end of [lambda2.dats] *)
