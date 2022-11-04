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
fprint_val<t1val> = fprint_t1val
//
(* ****** ****** *)
//
implement
print_t1val(t1v0) =
  fprint_t1val(stdout_ref, t1v0)
//
(* ****** ****** *)
implement
fprint_t1val(out, t1v0) =
(
case+ t1v0 of
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
T1Vtup(t1v1, t1v2) =>
fprint!
(out, "T1Vtup(", t1v1, ";", t1v2, ")")
|
T1Vlam(t1m0, env) =>
fprint!(out, "T1Vlam(", t1m0, ";", "...", ")")
|
T1Vfix(t1m0, env) =>
fprint!(out, "T1Vfix(", t1m0, ";", "...", ")")
//
|
T1Vcons(tag, t1vs) =>
fprint!(out, "T1Vcons(", tag, ";", t1vs, ")")
)
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_t1val.sats] *)
