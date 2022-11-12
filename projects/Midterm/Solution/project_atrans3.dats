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
(*
HX-2022-10-19:
For A-normal form
*)
//
datatype
//
t2cmp =
T2CMP of
(t2bndlst, t2box)
//
and
t2box =
//
| T2Vnil of ()
| T2Vint of int
| T2Vbtf of bool
| T2Vstr of string
//
| T2Varg of (t2arg)
| T2Vreg of (t2reg)
//
and t2ins =
//
|
T2Iopr of
(t1opr, t2boxlst)
//
|
T2Ifst of (t2box) // first projection
|
T2Isnd of (t2box) // second projection
|
T2Itup of (t2box, t2box) // pair formation
//
|
T2Iif0 of (t2box, t2bndlst, t2bndlst)
//
and
t2bnd =
T2BND of (t2reg, t2ins)
//
//
where
t2arg = int and
t2reg = int and
t2boxlst = mylist(t2box) and
t2bndlst = mylist(t2bnd) and t2inslst = mylist(t2ins)
//
(* ****** ****** *)
//
typedef
t2env =
mylist(@(t1var, t2cmp))
//
(* ****** ****** *)

extern
fun
t2reg_new(): t2reg

(* ****** ****** *)
(*
HX: for the a-norm-trans
*)
extern
fun
t1erm_atrans0(t1erm): t2cmp
extern
fun
t1dclist_atrans0(t1dclist): t2env
(* ****** ****** *)
extern
fun
t1erm_atrans1
(t1m0: t1erm, env0: t2env): t2cmp
extern
fun
t1dclist_atrans1
(dcls: t1dclist, env0: t2env): t2env
(* ****** ****** *)

local

val
the_count = ref<int>(0)

in//local

implement
t2reg_new
((*void*)) = n0 where
{
val n0 = the_count[]
val () = (the_count[] := n0 + 1)
}

end // end of [local(t2reg_new)]

(* ****** ****** *)
//
implement
t1erm_atrans0(t1m0) =
t1erm_atrans1(t1m0, mylist_nil())
//
(* ****** ****** *)
//
implement
t1dclist_atrans0
  (dcls) =
let
val
env0 = mylist_nil()
in t1dclist_atrans1(dcls, env0) end
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_atrans3.sats] *)
