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

implement T1Pint = T1Pbas("int")
implement T1Pbool = T1Pbas("bool")
implement T1Punit = T1Pbas("unit")
implement T1Pstring = T1Pbas("string")

(* ****** ****** *)
implement
fprint_val<t1ype> = fprint_t1ype
implement
fprint_val<ctype> = fprint_ctype
(* ****** ****** *)
//
implement
print_t1ype(t1p0) =
  fprint_t1ype(stdout_ref, t1p0)
//
implement
print_ctype(ctp0) =
  fprint_ctype(stdout_ref, ctp0)
//
(* ****** ****** *)

implement
fprint_t1ype(out, t1p0) =
(
case+ t1p0 of
|
T1Pnil() =>
fprint!(out, "T1Pnil(", ")")
|
T1Pbas(tpnm) =>
fprint!(out, "T1Pbas(", tpnm, ")")
|
T1Pext(tpxt) =>
fprint!(out, "T1Pext(", !tpxt, ")")
|
T1Pfun(t1p1, t1p2) =>
fprint!(out, "T1Pfun(", t1p1, ";", t1p2, ")")
|
T1Ptup(t1p1, t1p2) =>
fprint!(out, "T1Ptup(", t1p1, ";", t1p2, ")")
//
|
T1Plist(t1p1) =>
fprint!(out, "T1Plist(", t1p1, ")")
//
|
T1Pnone(s1e1) => fprint!(out, "T1Pnone(", s1e1, ")")
) (*case+*) // end of [fprint_t1ype(out,t1p0)]

(* ****** ****** *)
//
implement
fprint_ctype(out, ctp0) =
(
case+ ctp0 of
| CTYPE(t1ps, t1p1) =>
  fprint!(out, "CTYPE(", t1ps, ";", t1p1, ")")
) (*case+*) // end of [fprint_ctype(out, ctp0)]
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_t1ype.sats] *)
