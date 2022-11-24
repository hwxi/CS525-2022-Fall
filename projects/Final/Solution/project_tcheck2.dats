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
(*
typedef
t1ctx = mylist(@(t1var, t1ype))
*)
(* ****** ****** *)
//
extern
fun
t1erm_oftype1
(t1m0: t1erm, ctx0: t1ctx): t1ype
//
extern
fun
t1dclist_oftype1
(dcls: t1dclist, ctx0: t1ctx): t1ctx
//
(* ****** ****** *)
//
implement
t1erm_oftype0(t1m0) =
t1erm_oftype1(t1m0, mylist_nil())
//
(* ****** ****** *)
//
implement
t1dclist_oftype0
  (dcls) =
let
val
ctx0 = mylist_nil()
in t1dclist_oftype1(dcls, ctx0) end
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_tcheck2.dats] *)
