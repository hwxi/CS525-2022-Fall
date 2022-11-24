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
extern
fun
xatsopt_strunq
( source // "<string>" -> <string>
: string): string = "ext#xatsopt_strunq"
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
the_tpconlst =
$list{tpcnm}
( "*"
, "->"
, "list"
, "lazy"
, "strm"
) (* the_tpconlst *)
(* ****** ****** *)
overload .name
with $SYM.symbol_get_name
(* ****** ****** *)

fun
istpc
(nm0: tpcnm): bool =
(
search(nm0, the_tpconlst)
) where
{
fun
search
(nm0: tpcnm
,nms: List0(tpcnm)): bool =
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
//
fun
f0_id0
(s1e0: s1exp): t1ype =
(
case-
s1e0.node() of
|
S1Eid0(sym) =>
let
val
nam = sym.name()
in//let
case+ nam of
| "void" =>
  T1Pnil( ) | _ => T1Pbas(nam)
end (*let*) // end of [S1Eid0(sym)]
) (*case+*) // end of [f0_id0(s1e0)]
//
(* ****** ****** *)

fun
f0_app1
(s1e0: s1exp): t1ype =
let
val-
S1Eapp1
( s1f0
, s1e1) = s1e0.node()
//
val-
Some(tpc) = f0_tpc0(s1f0)
//
in//let
//
(
case- tpc of
| "list" =>
  T1Plist(t1p1) where
{
  val t1p1 = trans1m_s1exp(s1e1)
}
| "lazy" =>
  T1Plazy(t1p1) where
{
  val t1p1 = trans1m_s1exp(s1e1)
}
| "strm" =>
  T1Pstrm(t1p1) where
{
  val t1p1 = trans1m_s1exp(s1e1)
}
) where
{
(*
  val () =
  println!("f0_app1: tpc = ", tpc)
*)
} (*where*)
//
end (*let*) // end of [f0_app1(s1e0)]

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
f0_l1st
(s1e0: s1exp): t1ype =
let
//
val-
S1El1st(s1es) = s1e0.node()
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
end (*let*) // end of [f0_list(s1e0)]

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
end // end of [f0_s1es]

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
| S1El1st _ => f0_l1st(s1e0)
| S1Eapp1 _ => f0_app1(s1e0)
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
end (*let*) // end of [f0_f1as_tvar(f1as)]

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
D1Pl1st(d1ps) =>
(
  f0_dpat_tvar(d1p1)) where
{
  val-list_cons(d1p1, _) = d1ps
}
| D1Panno(d1p1, _) => f0_dpat_tvar(d1p1)
) (*case+*) // end of [f0_dpat_tvar(d1p0)]

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
D1Pl1st(d1ps) =>
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

local

typedef
oprnm = string

val
the_oprnmlst =
$list{oprnm} (
  "~"
, "+"
, "-"
, "*"
, "/"
, "%"
, ">"
, "<"
, "="
, "<="
, ">="
, "!="
(*
, "fst"
, "snd"
*)
, "show"
, "print"
, "showval"
//
, "list_nil"
, "list_cons"
, "list_nilq"
, "list_consq"
, "list_uncons1"
, "list_uncons2"
//
, "$lazy"
, "$eval"
, "strm_nil"
, "strm_cons"
, "strm_nilq"
, "strm_consq"
, "strm_uncons1"
, "strm_uncons2"
//
) (* the_oprnmlst *)

(* ****** ****** *)

fun
isopr
(nm0: oprnm): bool =
(
search(nm0, the_oprnmlst)
) where
{
fun
search
( nm0: oprnm
, nms: List0(oprnm)): bool =
(
case+ nms of
|
list_nil() => false
|
list_cons(nm1, nms) =>
if (nm0 = nm1)
then true else search(nm0, nms)
)
} (*where*) // end of [isopr(nm0)]

(* ****** ****** *)

fun
f0_opr
( d1e0
: d1exp)
: Option(oprnm) =
(
case+
d1e0.node() of
|
D1Eid0(tok) =>
(
case-
tok.node() of
| T_IDENT_alp(nm0) =>
  if
  isopr(nm0)
  then Some(nm0) else None()
| T_IDENT_sym(nm0) =>
  if
  isopr(nm0)
  then Some(nm0) else None()
| T_IDENT_dlr(nm0) =>
  if
  isopr(nm0)
  then Some(nm0) else None()
)
|
_ (*non-D1Eid*) => None((*void*))
) where
{
(*
val () =
println!("f0_opr: d1e0 = ", d1e0)
*)
} (*where*) // end of [f0_opr(d1e0)]

(* ****** ****** *)

fun
f0_id0
( d1e0
: d1exp): t1erm =
(
case-
d1e0.node() of
|
D1Eid0(tok) =>
(
case-
tok.node() of
|
T_IDENT_alp(nam) =>
(
case+ nam of
| "true" =>
T1Mbtf(true)
| "false" =>
T1Mbtf(false) | _ => T1Mvar(nam)
)
| T_IDENT_sym(nam) => T1Mvar(nam)
)
)

(* ****** ****** *)

fun
f0_int
( d1e0
: d1exp): t1erm =
(
case-
d1e0.node() of
|
D1Eint(tok) =>
(
case-
tok.node() of
|
T_INT1(rep) =>
T1Mint(g0string2int(rep))
)
) (*case-*) // end of [f0_int(d1e0)]

(* ****** ****** *)

fun
f0_str
( d1e0
: d1exp): t1erm =
(
case-
d1e0.node() of
|
D1Estr(tok) =>
(
case-
tok.node() of
|
T_STRING_closed(rep) =>
T1Mstr(xatsopt_strunq(rep))
)
) (*case-*) // end of [f0_str(d1e0)]

(* ****** ****** *)

fun
f0_l1st
( d1e0
: d1exp): t1erm =
(
  f0_d1es(d1es)) where
{
//
val-
D1El1st(d1es) = d1e0.node()
//
fun
f0_d1es
(d1es: d1explst): t1erm =
(
case+ d1es of
|
list_nil() => T1Mnil()
|
list_cons
(d1e1, d1es) =>
let
val
t1m1 = trans1m_d1exp(d1e1)
in//let
//
if
iseqz(d1es)
then (t1m1)
else T1Mtup(t1m1, f0_d1es(d1es))
//
end (*let*) // end of [list_cons]
)
//
} (*where*) // end of [f0_list(d1e0)]

(* ****** ****** *)

fun
f0_if0
( d1e0
: d1exp): t1erm =
let
//
val-
D1Eif0
( d1e1
, d1e2
, opt3) = d1e0.node()
//
in
//
(
T1Mif0
(t1m1, t1m2, opt3)) where
{
val
t1m1 = trans1m_d1exp(d1e1)
val
t1m2 = trans1m_d1exp(d1e2)
val
opt3 = trans1m_d1expopt(opt3) }
//
end (*let*) // end of [f0_if0(d1e0)]

(* ****** ****** *)

fun
t1erm_seq
(t1ms: t1ermlst): t1erm =
(
case+ t1ms of
|
mylist_nil() => T1Mnil()
|
mylist_cons(t1m1, tms2) =>
(
case+ tms2 of
|
mylist_nil
((*void*)) => t1m1 | _ => T1Mseq(t1ms))
) (*case+*) // end of [t1erm_seq(t1ms)]

(* ****** ****** *)

fun
f0_let
( d1e0
: d1exp): t1erm =
let
//
val-
D1Elet
( d1cs
, d1es) = d1e0.node()
//
in
(
  T1Mlet(t1ds, t1m1)
) where
{
val
t1ds =
trans1m_d1eclist(d1cs)
val
t1m1 =
t1erm_seq(trans1m_d1explst(d1es))
}
end (*let*) // end of [f0_let(d1e0)]

(* ****** ****** *)

fun
f0_lam
( d1e0
: d1exp): t1erm =
let
val-
D1Elam
( tlam
, f1as
, res0
, arrw
, body) = d1e0.node()
val farg =
trans1m_f1as_tvar(f1as)
val topt =
trans1m_f1as_type(f1as)
val body = trans1m_d1exp(body)
in
case+ res0 of
|
EFFS1EXPnone() =>
T1Mlam(farg, topt, body)
|
EFFS1EXPsome(s1e0) =>
(
T1Mlam
( farg
, topt, T1Manno(body, tres))
) where
{
  val tres = trans1m_s1exp(s1e0)
}
end (*let*) // end of [f0_lam(d1e0)]

(* ****** ****** *)

fun
f0_fix
( d1e0
: d1exp): t1erm =
let
val-
D1Efix
( tfix
, fid0
, f1as
, res0
, arrw
, body) = d1e0.node()
val fid0 =
(
case-
fid0.node() of
|
T_IDENT_alp(nam) => nam
|
T_IDENT_sym(nam) => nam
) : t1var // end-of-val
//
val farg =
trans1m_f1as_tvar(f1as)
val topt =
trans1m_f1as_type(f1as)
val body = trans1m_d1exp(body)
//
in
case+ res0 of
| EFFS1EXPnone() =>
  (
  T1Mfix
  ( fid0, farg
  , topt, body, tres)
  ) where
  {
    val tres = myoptn_nil()
  }
| EFFS1EXPsome(s1e0) =>
  (
  T1Mfix
  ( fid0, farg
  , topt, body, tres)) where
  {
    val tres =
    myoptn_cons(trans1m_s1exp(s1e0))
  }
end (*let*) // end of [f0_fix(d1e0)]

(* ****** ****** *)

fun
t1erm_app
( t1m1: t1erm
, t1m2: t1erm): t1erm =
(
case+ t1m1 of
//
|
T1Mvar("fst") => T1Mfst(t1m2)
|
T1Mvar("snd") => T1Msnd(t1m2)
//
|
_(*otherwise*) => T1Mapp(t1m1, t1m2)
//
) (*case+*) // end-[t1erm_app(t1m1,t1m2)]

(* ****** ****** *)

fun
f0_app1
(d1e0: d1exp): t1erm =
let
//
val-
D1Eapp1
( d1e1
, d1e2) = d1e0.node()
//
val opt1 = f0_opr(d1e1)
//
in
//
case+ opt1 of
|
None() =>
(
t1erm_app
(t1m1, t1m2)) where
{
val
t1m1 = trans1m_d1exp(d1e1)
val
t1m2 = trans1m_d1exp(d1e2)
}
|
Some(opnm) =>
(
case+ opnm of
//
| "$lazy" =>
(
T1Mlazy(t1m2)) where
{
val
t1m2 = trans1m_d1exp(d1e2)
} (*where*) // end-of-($lazy)
//
| _(*rest*) =>
(
T1Mopr(opnm, t1ms)) where
{
val t1ms =
(
//
case+
d1e2.node() of
|
D1El1st(d1es) =>
trans1m_d1explst(d1es)
|
_(*non-D1Elist*) =>
(
mylist_sing
(trans1m_d1exp(d1e2))))
: t1ermlst // end-of-val(t1ms)
} (*where*) // end of [(*rest*)]
)
//
end (*let*) // end of [f0_app1(d1e0)]

(* ****** ****** *)

fun
f0_app2
( d1e0
: d1exp): t1erm =
let
val-
D1Eapp2
( d1e1
, d1e2
, d1e3) = d1e0.node()
//
val opt1 = f0_opr(d1e1)
val t1m2 = trans1m_d1exp(d1e2)
val t1m3 = trans1m_d1exp(d1e3)
in
//
case+ opt1 of
|
None() =>
let
val t1m1 = trans1m_d1exp(d1e1)
in//let
  T1Mapp(t1m1, T1Mtup(t1m2, t1m3))
end // end of [None]
|
Some(opr1) =>
T1Mopr(opr1, mylist_pair(t1m2, t1m3))
//
end (*let*) // end of [f0_app2(d1e0)]

(* ****** ****** *)

fun
f0_seqn
( d1e0
: d1exp): t1erm =
(
t1erm_seq
(
trans1m_d1explst
(list_append(des1, des2)))
) where
{
  val-
  D1Eseqn
  (des1, des2) = d1e0.node()
}

(* ****** ****** *)

fun
f0_anno
( d1e0
: d1exp): t1erm =
let
val-
D1Eanno
( d1e1
, s1e2) = d1e0.node()
//
in
(
  T1Manno(t1m1, t1p2)) where
{
  val t1m1 = trans1m_d1exp(d1e1)
  val t1p2 = trans1m_s1exp(s1e2)
}
end (*let*) // end of [f0_anno(d1e0)]

(* ****** ****** *)

fun
f0_where
( d1e0
: d1exp): t1erm =
let
//
val-
D1Ewhere
( d1e1
, d1cs) = d1e0.node()
//
in
(
  T1Mlet(t1ds, t1m1)
) where
{
val
t1ds = trans1m_d1eclist(d1cs)
val t1m1 = trans1m_d1exp(d1e1)
}
end (*let*) // end of [f0_where(d1e0)]

(* ****** ****** *)

in(*in-of-local*)
//
implement
trans1m_d1exp
  (d1e0) =
(
case+
d1e0.node() of
//
| D1Eid0 _ => f0_id0(d1e0)
| D1Eint _ => f0_int(d1e0)
| D1Estr _ => f0_str(d1e0)
//
| D1Eif0 _ => f0_if0(d1e0)
| D1Elet _ => f0_let(d1e0)
| D1Elam _ => f0_lam(d1e0)
| D1Efix _ => f0_fix(d1e0)
//
| D1El1st _ => f0_l1st(d1e0)
//
| D1Eseqn _ => f0_seqn(d1e0)
//
| D1Eapp1 _ => f0_app1(d1e0)
| D1Eapp2 _ => f0_app2(d1e0)
//
| D1Eanno _ => f0_anno(d1e0)
//
| D1Ewhere _ => f0_where(d1e0)
//
| _(*rest-of-d1exp*) => T1Mnone(d1e0)
) where
{
(*
val () =
println!("trans1m_d1exp: d1e0 = ", d1e0)
*)
} (*where*) // end of [trans1m_d1exp(d1e0)]
//
end (*let*) // end of [local(trans1m_d1exp)]

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

local

fun
ismain
( f1d0
: d1fundecl): bool =
let
val+
D1FUNDECL
(rcd) = f1d0
//
val nam = rcd.nam
//
in
case+
nam.node() of
|
T_IDENT_alp
(nam) =>
(nam = "main") | _ => false
end (*let*) // end of [ismain]

(* ****** ****** *)

fun
f0_v1d0
( v1d0
: d1valdecl): t1dcl =
(
T1DCLbind
(xid, def)) where
{
val+
D1VALDECL(rcd) = v1d0
//
val xid =
let
val
d1p = rcd.pat
in
case-
d1p.node() of
|
D1Pid0(tok) =>
(
case-
tok.node() of
|
T_IDENT_alp(nam) => nam
|
T_IDENT_sym(nam) => nam
)
end : t1var // end-of-val
//
val def =
(
case-
rcd.def of
Some(d1e) =>
trans1m_d1exp(d1e)): t1erm
//
} (*where*) // end of [f0_v1d0(v1d0)]

and
f0_v1ds
( v1ds
: d1valdeclist
) : t1dclist =
(
case+ v1ds of
| list_nil() =>
  mylist_nil()
| list_cons
  (v1d0, v1ds) =>
  mylist_cons
  (f0_v1d0(v1d0), f0_v1ds(v1ds))
) (*case+*) // end of [f0_v1ds(v1ds)]

(* ****** ****** *)

fun
f0_f1d0
( f1d0
: d1fundecl
) : t1dcl =
let
val+
D1FUNDECL(rcd) = f1d0
//
val
nam = rcd.nam
//
val fid0 =
(
case-
nam.node() of
|
T_IDENT_alp(nam) => nam
|
T_IDENT_sym(nam) => nam
) : t1var // end of [val]
//
val farg =
trans1m_f1as_tvar(rcd.arg)
val topt =
trans1m_f1as_type(rcd.arg)
//
val body =
(
case-
rcd.def of
|
Some(d1e0) =>
trans1m_d1exp(d1e0)): t1erm
//
in
(
T1DCLbind(fid0, fdef)) where
{
val fdef =
(
case+ rcd.res of
|
EFFS1EXPnone() =>
(
T1Mfix
( fid0
, farg, topt, body, tres)
) where
{
  val tres = myoptn_nil()
}
|
EFFS1EXPsome(s1e0) =>
(
T1Mfix
( fid0
, farg, topt, body, tres)
) where
{
  val tres =
  myoptn_cons
  ( trans1m_s1exp(s1e0) ) }
) : t1erm // end-of-val(body)
}
end (*let*) // end of [f0_f1d0(f1d0)]

and
f0_f1ds
( f1ds
: d1fundeclist
) : t1dclist =
(
case+ f1ds of
|
list_nil() =>
mylist_nil()
|
list_cons
(f1d0, f1ds) =>
(
if
ismain(f1d0)
then
mylist_nil(*void*)
else
mylist_cons
(f0_f1d0(f1d0), mylist_nil(*void*)))
) (*case+*) // end of [f0_f1ds(f1ds)]

in(*in-of-local*)

(* ****** ****** *)

implement
trans1m_d1eclist
  (d1cs) =
(
case+ d1cs of
|
list_nil() =>
mylist_nil()
|
list_cons(d1c0, d1cs) =>
(
case+
d1c0.node() of
|
D1Cvaldclst(_, _, v1ds) =>
let
  val t1ds = f0_v1ds(v1ds)
in
  mylist_append
  (t1ds, trans1m_d1eclist(d1cs))
end (*let*) // end-of(D1Cvaldecl)
|
D1Cfundclst(_, _, _, f1ds) =>
let
  val f1ds = f0_f1ds(f1ds)
in
  mylist_append
  (f1ds, trans1m_d1eclist(d1cs))
end (*let*) // end-of(D1Cfundecl)
| _(*rest-of-d1ecl*) => trans1m_d1eclist(d1cs)
)
) (*case+*) // end of [trans1m_d1eclist(d1cs)]

(* ****** ****** *)

implement
trans1m_main_fun
  (d1cs) =
(
case+ d1cs of
|
list_nil() =>
myoptn_nil()
|
list_cons(d1c0, d1cs) =>
(
case+
d1c0.node() of
|
D1Cfundclst
(_, _, _, f1ds) =>
(
f0_f1ds(f1ds)) where
{
//
fun
f0_f1d0
( f1d0
: d1fundecl): t1ermopt =
let
val+
D1FUNDECL(rcd) = f1d0
in//let
case+ rcd.def of
| None() =>
  myoptn_nil()
| Some(d1e) =>
  myoptn_cons(trans1m_d1exp(d1e))
end (*let*) // end of [f0_f1d0(f1d0)]
//
and
f0_f1ds
( f1ds
: d1fundeclist): t1ermopt =
(
case+ f1ds of
|
list_nil() =>
trans1m_main_fun(d1cs)
|
list_cons(f1d0, f1ds) =>
if
ismain(f1d0)
then
f0_f1d0(f1d0) else f0_f1ds(f1ds)
) (*case+*) // end of [f0_f1ds(f1ds)]
//
}
|
_(*non-D1Cfundclst*) => trans1m_main_fun(d1cs)
)
) (* case+*) // end of [trans1m_main_fun(d1cs)]

(* ****** ****** *)

end (*local*) // end of [local(trans1m_d1eclist)]

(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_trans.sats] *)
