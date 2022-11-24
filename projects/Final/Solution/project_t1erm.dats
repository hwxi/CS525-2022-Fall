(* ****** ****** *)
#staload "./project.sats"
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
#staload
"./../../../mylib/mylib.dats"
(* ****** ****** *)
//
#include
"./../../HATS/libxatsopt.hats"
//
(* ****** ****** *)
//
implement
fprint_val<t1ype> = fprint_t1ype
//
(* ****** ****** *)
//
implement
fprint_val<t1erm> = fprint_t1erm
implement
fprint_val<t1dcl> = fprint_t1dcl
//
(* ****** ****** *)
//
implement
print_t1erm(t1m0) =
  fprint_t1erm(stdout_ref, t1m0)
implement
print_t1dcl(tdcl) =
  fprint_t1dcl(stdout_ref, tdcl)
//
(* ****** ****** *)

implement
fprint_t1erm(out, t1m0) =
(
//
case+ t1m0 of
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
T1Mvar(t1v1) =>
fprint!(out, "T1Mvar(", t1v1, ")")
|
T1Mlam(t1vx, targ, t1m1) =>
fprint!
( out, "T1Mlam("
, t1vx, ";", targ, ";", t1m1, ")")
|
T1Mapp(t1m1, t1m2) =>
fprint!
(out, "T1Mapp(", t1m1, ";", t1m2, ")")
//
|
T1Mfst(t1m1) =>
fprint!(out, "T1Mfst(", t1m1, ")")
|
T1Msnd(t1m1) =>
fprint!(out, "T1Msnd(", t1m1, ")")
|
T1Mtup(t1m1, t1m2) =>
fprint!
(out, "T1Mtup(", t1m1, ";", t1m2, ")")
//
|
T1Mseq(t1ms) =>
fprint!(out, "T1Mseq(", t1ms, ")")
//
|
T1Mopr(topr, t1ms) =>
fprint!
(out, "T1Mopr(", topr, ";", t1ms, ")")
//
|
T1Mif0
(t1m1, t1m2, opt3) =>
fprint!
(out, "T1Mif0(", t1m1, ";", t1m2, ";", opt3)
//
|
T1Mlet(dcls, t1m1) =>
fprint!(out, "T1Mlet(", dcls, ";", t1m1)
//
|
T1Mfix
( t1vf, t1vx
, targ, t1m1, tres) =>
fprint!
( out, "T1Mfix("
, t1vf, ";", t1vx, ";", targ, ";", t1m1, ";", tres, ")")
//
|
T1Mlazy(t1m1) =>
fprint!(out, "T1Mlazy(", t1m1, ")")
//
|
T1Manno(t1m1, t1p2) =>
fprint!(out, "T1Manno(", t1m1, ";", t1p2, ")")
//
| // HX: it is for error indcation:
T1Mnone(d1e1) => fprint!(out, "T1Mnone(", d1e1, ")")
//
) (*case+*) // end of [fprint_t1erm(out, t1m0)]

(* ****** ****** *)
//
implement
fprint_t1dcl(out, tdcl) =
(
//
case+ tdcl of
|
T1DCLbind(t1v1, t1m2) =>
fprint!(out, "T1DCLbind(", t1v1, ";",  t1m2, ")")
(*
| // HX: it is for error indcation:
T1DCLnone(d1cl) => fprint!(out, "T1DCLnone(", d1cl, ")")
*)
//
) (*case+*) // end of [fprint_t1dcl(out, tdcl)]
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_t1erm.sats] *)
