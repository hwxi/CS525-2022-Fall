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

local

(* ****** ****** *)
typedef
tpcnm = string
(* ****** ****** *)
val
the_tpcon_lst =
$list{string}
( "*"
, "->"
) (* the_tpcon_list *)
(* ****** ****** *)
overload .name
with $SYM.symbol_get_name
(* ****** ****** *)

fun
istpc
(nm0: string): bool =
(
search(nm0, the_tpcon_lst)
) where
{
fun
search
(nm0: string
,nms: List0(string)): bool =
(
case+ nms of
|
list_nil() => false
|
list_cons(nm1, nms) =>
if (nm0 = nm1)
then true else search(nm0, nms)
)
} (*where*) // end of [istpc(nm0)]

(* ****** ****** *)

fun
f0_tpc0
( s1e0
: s1exp)
: Option(tpcnm) =
(
case+
s1e0.node() of
|
S1Eid0(sym) =>
let
val nm0 = sym.name()
in
if
istpc(nm0)
then Some(nm0) else None()
end // end of [S1Eid]
|
_ (*non-S1Eid*) => None((*void*))
)

(* ****** ****** *)

fun
f0_id0
(s1e0: s1exp): t1ype =
(
case-
s1e0.node() of
|
S1Eid0(sym) => T1Pbas(sym.name())
)

(* ****** ****** *)

fun
f0_app2
(s1e0: s1exp): t1ype =
let
val-
S1Eapp2
( s1f0
, s1e1
, s1e2) = s1e0.node()
//
val-
Some(tpc) = f0_tpc0(s1f0)
//
in//let
//
(
case- tpc of
| "*" =>
  T1Ptup(t1p1, t1p2)
| "->" =>
  T1Pfun(t1p1, t1p2)) where
{
  val t1p1 = trans1m_s1exp(s1e1)
  val t1p2 = trans1m_s1exp(s1e2)
}
//
end (*let*) // end of [f0_app2(s1e0)]

(* ****** ****** *)

fun
f0_list
(s1e0: s1exp): t1ype =
let
//
val-
S1Elist(s1es) = s1e0.node()
//
in//let
//
case+ s1es of
|
list_nil
((*void*)) => T1Pnil((*void*))
|
list_cons
(s1e1, s1es) => f0_s1es(s1e1, s1es)
//
end (*let*) // end of [auxlist(s1e0)]

and
f0_s1es
( s1e1: s1exp
, s1es: s1explst): t1ype =
let
val
t1p1 = trans1m_s1exp(s1e1)
in//let
case+ s1es of
| list_nil
  ((*void*)) => t1p1
| list_cons
  (s1e2, s1es) =>
  T1Ptup(t1p1, f0_s1es(s1e2, s1es))
end // end of [auxs1es]

in (*in-of-local*)
//
implement
trans1m_s1exp
  (s1e0) =
(
case+
s1e0.node() of
//
| S1Eid0 _ => f0_id0(s1e0)
//
| S1Elist _ => f0_list(s1e0)
| S1Eapp2 _ => f0_app2(s1e0)
//
| _(*rest-of-s1exp*) => T1Pnone(s1e0)
//
) where
{
(*
val () =
println!("trans1m_s1exp: s1e0 = ", s1e0)
*)
} (*where*) // end of [trans1m_s1exp(s1e0)]
//
(* ****** ****** *)

end (*local*) // end of [local(trans1m_s1exp)]

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

local

fun
f0_f1as_tvar
( f1as
: f1arglst): t1var =
let
val-
list_cons
(f1a0, _) = f1as
in
case-
f1a0.node() of
|
F1ARGsome_dyn
  ( d1p0 ) => f0_dpat_tvar(d1p0)
end // end of [f0_f1as_var(f1as)]

and
f0_dpat_tvar
(d1p0: d1pat): t1var =
(
case-
d1p0.node() of
|
D1Pid0(tok1) =>
(
case-
tok1.node() of
|
T_IDENT_alp(nam1) => nam1
|
T_IDENT_sym(nam1) => nam1
)
|
D1Plist(d1ps) =>
(
  f0_dpat_tvar(d1p1)) where
{
  val-list_cons(d1p1, _) = d1ps
}
| D1Panno(d1p1, _) => f0_dpat_tvar(d1p1)
)

(* ****** ****** *)

fun
f0_f1as_type
( f1as
: f1arglst): t1ypeopt =
let
val-
list_cons(f1a1, _) = f1as
in
case-
f1a1.node() of
|
F1ARGsome_dyn
  ( d1p1 ) => f0_dpat_type(d1p1)
end (*let*) // end of [f0_anno_type(f1as)]

and
f0_dpat_type
( d1p0
: d1pat): t1ypeopt =
(
case-
d1p0.node() of
|
D1Plist(d1ps) =>
(
  f0_dpat_type(d1p1)
) where
{
  val-list_cons(d1p1, _) = d1ps
}
|
D1Panno(_, s1e2) =>
myoptn_cons(trans1m_s1exp(s1e2))
|
_(*rest-of-d1pat*) => myoptn_nil()
) (*case+*) // end of [f0_dpat_type(d1p0)]

in//local

fun
trans1m_f1as_tvar
( f1as
: f1arglst): t1var = f0_f1as_tvar(f1as)
fun
trans1m_f1as_type
( f1as
: f1arglst): t1ypeopt = f0_f1as_type(f1as)

end (*local*) // end of [local(trans1m_f1as)]

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
