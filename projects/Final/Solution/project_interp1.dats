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
extern
fun
t1erm_interp1
( t1m0
: t1erm, env0: t1env): t1val
extern
fun
t1ermlst_interp1
( t1ms
: t1ermlst, env0: t1env): t1valist
(* ****** ****** *)
//
implement
t1erm_interp0(t1m0) =
t1erm_interp1(t1m0, mylist_nil())
//
(* ****** ****** *)
//
implement
t1dclist_interp0
  (dcls) =
let
val
env0 = mylist_nil()
in t1dclist_interp1(dcls, env0) end
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_interp1.dats] *)
