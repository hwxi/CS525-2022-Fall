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
implement
fprint_val<ctype> = fprint_ctype
//
implement
fprint_val<t1erm> = fprint_t1erm
implement
fprint_val<t1dcl> = fprint_t1dcl
//
(* ****** ****** *)
implement
trans_s1exp
  (s1e0) = T1Pnone(s1e0)
(* ****** ****** *)
//
implement
trans_s1explst
  (s1es) =
(
case+ s1es of
|
list_nil() =>
mylist_nil()
|
list_cons(s1e1, s1es) =>
mylist_cons(t1m1, t1ms) where
{
  val t1m1 = trans_s1exp(s1e1)
  val t1ms = trans_s1explst(s1es)
}
) (*case+*) // end of [trans_s1explst]
//
(* ****** ****** *)
//
implement
trans_s1expopt
  (sopt) =
(
case+ sopt of
| None() => myoptn_nil()
| Some(s1e0) =>
  myoptn_cons(trans_s1exp(s1e0)))
//(*case+*) // end of [trans_s1expopt]
//
(* ****** ****** *)
//
implement
trans_d1exp
  (d1e0) = T1Mnone(d1e0)
//
(* ****** ****** *)
//
implement
trans_d1explst
  (d1es) =
(
case+ d1es of
|
list_nil() =>
mylist_nil()
|
list_cons(d1e1, d1es) =>
mylist_cons(t1m1, t1ms) where
{
  val t1m1 = trans_d1exp(d1e1)
  val t1ms = trans_d1explst(d1es)
}
) (*case+*) // end of [trans_d1explst]
//
(* ****** ****** *)
//
implement
trans_d1expopt
  (dopt) =
(
case+ dopt of
| None() => myoptn_nil()
| Some(d1e0) =>
  myoptn_cons(trans_d1exp(d1e0)))
//(*case+*) // end of [trans_d1expopt]
//
(* ****** ****** *)

implement
trans_d1ecl
  (d1cl) = T1Cnone(d1cl)

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_trans.sats] *)
