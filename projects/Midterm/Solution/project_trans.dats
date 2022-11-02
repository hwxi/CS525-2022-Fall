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
//
implement
trans1m_s1exp
  (s1e0) =
(
case+
s1e0.node() of
| _(*rest-of-s1exp*) => T1Pnone(s1e0)
) where
{
(*
val () =
println!("trans1m_s1exp: s1e0 = ", s1e0)
*)
} (*where*) // end of [trans1m_s1exp(s1e0)]
//
(* ****** ****** *)
//
implement
trans1m_s1explst
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
  val t1m1 = trans1m_s1exp(s1e1)
  val t1ms = trans1m_s1explst(s1es)
}
) (*case+*) // end of [trans1m_s1explst]
//
(* ****** ****** *)
//
implement
trans1m_s1expopt
  (sopt) =
(
case+ sopt of
| None() => myoptn_nil()
| Some(s1e0) =>
  myoptn_cons(trans1m_s1exp(s1e0)))
//(*case+*) // end of [trans1m_s1expopt]
//
(* ****** ****** *)
//
implement
trans1m_d1exp
  (d1e0) =
(
case+
d1e0.node() of
| _(*rest-of-d1exp*) => T1Mnone(d1e0)
) where
{
(*
val () =
println!("trans1m_d1exp: d1e0 = ", d1e0)
*)
} (*where*) // end of [trans1m_d1exp(d1e0)]
//
(* ****** ****** *)
//
implement
trans1m_d1explst
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
  val t1m1 = trans1m_d1exp(d1e1)
  val t1ms = trans1m_d1explst(d1es)
}
) (*case+*) // end of [trans1m_d1explst]
//
(* ****** ****** *)
//
implement
trans1m_d1expopt
  (dopt) =
(
case+ dopt of
| None() => myoptn_nil()
| Some(d1e0) =>
  myoptn_cons(trans1m_d1exp(d1e0)))
//(*case+*) // end of [trans1m_d1expopt]
//
(* ****** ****** *)

implement
trans1m_d1ecl
  (d1cl) =
(
case+
d1cl.node() of
| _(*rest-of-d1ecl*) => T1Dnone(d1cl)
) where
{
(*
val () =
println!("trans1m_d1ecl: d1cl = ", d1cl)
*)
} (*where*) // end of [trans1m_d1ecl(d1cl)]

(* ****** ****** *)
//
implement
trans1m_d1eclist
  (dcls) =
(
case+ dcls of
|
list_nil() =>
mylist_nil()
|
list_cons(d1cl, dcls) =>
mylist_cons(t1d1, t1ds) where
{
  val t1d1 = trans1m_d1ecl(d1cl)
  val t1ds = trans1m_d1eclist(dcls)
}
) (*case+*) // end of [trans1m_d1eclist(dcls)]
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_trans.sats] *)
