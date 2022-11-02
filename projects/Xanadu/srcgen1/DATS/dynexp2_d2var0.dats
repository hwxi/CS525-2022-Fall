(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2020 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: March, 2020
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/xstamp0.sats"
//
#staload "./../SATS/xsymbol.sats"
#staload "./../SATS/lexing0.sats"
//
#staload "./../SATS/trans01.sats"
//
#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
//
(* ****** ****** *)

#define ND2VAR 4*1024

(* ****** ****** *)

(*
datatype
s2eopt =
| S2EOPTnone of ()
| S2EOPTsome of s2exp
datatype
d2vopt =
| D2VOPTnone of ()
| D2VOPTsome of d2var
*)

(* ****** ****** *)

local

typedef
d2var_struct = @{
//
  d2var_loc= loc_t // loc
, d2var_sym= sym_t // name
, d2var_kind= tnode // kind
, d2var_kmut= (int) // kmut
, d2var_tqas= tq2as // tqas
, d2var_sexp= s2exp // sexp
, d2var_type= t2ype // type
, d2var_stamp= stamp // unicity
//
(*
// HX:
// it is done externally
, d2var_saddr= s2eopt // static address
, d2var_atprf= d2vopt // proof-of-atview 
*)
//
} (* end of [d2var_tbox] *)

absimpl
d2var_tbox=ref(d2var_struct)

in (* in-of-local *)

implement
d2var_new1
  (tok) = let
//
val
loc = tok.loc()
val
sym = dexpid_sym(tok)
//
in
  d2var_new2(loc, sym)
end // end of [d2var_new1]

(* ****** ****** *)
//
implement
d2var_new2
(loc, sym) =
d2var_make_idvk
(loc, sym, T_EOF(*kind*))
//
implement
d2var_make_idvk
(loc, sym, kvar) =
(
( d2v0 ) where
{
//
val
d2v0 =
ref<d2var_struct>
@{
//
  d2var_loc= loc
, d2var_sym= sym
//
, d2var_kind= kvar
//
, d2var_kmut= kmut
, d2var_tqas= tqas
, d2var_sexp= s2e1
, d2var_type= t2p2
//
, d2var_stamp= stamp
//
}
//
val () =
stamp_d2var_saddr(d2v0)
val () =
stamp_d2var_atprf(d2v0)
val () =
stamp_d2var_msexp(d2v0)
//
}
) where
{
//
  val kmut = 0//default
//
  val tqas = list_nil()
//
  val s2e1 = the_s2exp_none0
  val t2p2 = the_t2ype_none0
//
  val stamp = d2var_stamp_new()
//
} (*where*) // [d2var_make_idvk]
//
(* ****** ****** *)
//
implement
d2var_get_loc(x0) = x0->d2var_loc
implement
d2var_get_sym(x0) = x0->d2var_sym
//
implement
d2var_get_kind(x0) = x0->d2var_kind
implement
d2var_get_kmut(x0) = x0->d2var_kmut
//
implement
d2var_get_tqas(x0) = x0->d2var_tqas
implement
d2var_get_sexp(x0) = x0->d2var_sexp
implement
d2var_get_type(x0) = x0->d2var_type
implement
d2var_get_stamp(x0) = x0->d2var_stamp
//
implement
d2var_set_kmut
  (x0, kmut) = (x0->d2var_kmut := kmut)
//
implement
d2var_set_tqas
  (x0, tqas) = (x0->d2var_tqas := tqas)
implement
d2var_set_sexp
  (x0, s2e0) = (x0->d2var_sexp := s2e0)
implement
d2var_set_type
  (x0, t2p0) = (x0->d2var_type := t2p0)
//
end // end of [local]

(* ****** ****** *)

local
//
#staload
"libats/SATS/dynarray.sats"
#staload _ =
"libats/DATS/dynarray.dats"
//
typedef itm = s2expopt
vtypedef dynarray = dynarray(itm)
//
val
theDynarr = 
dynarray_make_nil<itm>(i2sz(ND2VAR))
val
theDynarr = $UN.castvwtp0{ptr}(theDynarr)
//
in (* in-of-local *)

implement
d2var_get_saddr
  (d2v0) = let
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
  val cp = dynarray_getref_at(A0, i0)
  prval((*void*)) = $UN.cast2void(A0)
//
in
//
if
isneqz(cp)
then $UN.p2tr_get(cp) else None(*void*)
//
end // end of [d2var_get_saddr]

(* ****** ****** *)

implement
stamp_d2var_saddr
  (d2v0) = let
//
(*
val () =
println!
("stamp_d2var_saddr: d2v0 = ", d2v0)
*)
//
val s0 =
d2v0.stamp()
val i0 =
stamp2uint(s0)
val i0 =
u2sz(g1ofg0(i0))
val A0 =
$UN.castvwtp0{dynarray}(theDynarr)
//
val itm = None()
val-
~None_vt() =
dynarray_insert_at_opt(A0, i0, itm)
//
prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [stamp_d2var_saddr]

(* ****** ****** *)

implement
d2var_set_saddr
  (d2v0, s2l1) = let
//
(*
val () =
println!
("d2var_set_saddr: d2v0 = ", d2v0)
val () =
println!
("d2var_set_saddr: s2l1 = ", s2l1)
*)
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
//
  val () =
  let
  val itm = Some(s2l1)
  in
  dynarray_set_at_exn<itm>(A0, i0, itm)
  end
//
  prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [d2var_set_saddr]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local
//
#staload
"libats/SATS/dynarray.sats"
#staload _ =
"libats/DATS/dynarray.dats"
//
typedef itm = d2varopt
vtypedef dynarray = dynarray(itm)
//
val
theDynarr = 
dynarray_make_nil<itm>(i2sz(ND2VAR))
val
theDynarr = $UN.castvwtp0{ptr}(theDynarr)
//
in (* in-of-local *)

implement
d2var_get_atprf
  (d2v0) = let
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
  val cp = dynarray_getref_at(A0, i0)
  prval((*void*)) = $UN.cast2void(A0)
//
in
//
if
isneqz(cp)
then $UN.p2tr_get(cp) else None(*void*)
//
end // end of [d2var_get_atprf]

(* ****** ****** *)

implement
d2var_set_atprf
  (d2v0, d2w1) = let
//
(*
val () =
println!
("d2var_set_atprf: d2v0 = ", d2v0)
val () =
println!
("d2var_set_atprf: d2w1 = ", d2w1)
*)
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
//
  val () =
  let
  val itm = Some(d2w1)
  in
  dynarray_set_at_exn<itm>(A0, i0, itm)
  end
//
  prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [d2var_set_atprf]

(* ****** ****** *)

implement
stamp_d2var_atprf
  (d2v0) = let
//
(*
val () =
println!
("stamp_d2var_atprf: d2v0 = ", d2v0)
*)
//
val s0 =
d2v0.stamp()
val i0 =
stamp2uint(s0)
val i0 =
u2sz(g1ofg0(i0))
val A0 =
$UN.castvwtp0{dynarray}(theDynarr)
//
val itm = None()
val-
~None_vt() =
dynarray_insert_at_opt(A0, i0, itm)
//
prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [stamp_d2var_atprf]

end // end of [local]

(* ****** ****** *)

local
//
#staload
"libats/SATS/dynarray.sats"
#staload _ =
"libats/DATS/dynarray.dats"
//
typedef itm = s2expopt
vtypedef dynarray = dynarray(itm)
//
val
theDynarr = 
dynarray_make_nil<itm>(i2sz(ND2VAR))
val
theDynarr = $UN.castvwtp0{ptr}(theDynarr)
//
in (* in-of-local *)

implement
d2var_get_msexp
  (d2v0) = let
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
  val cp = dynarray_getref_at(A0, i0)
  prval((*void*)) = $UN.cast2void(A0)
//
in
//
if
isneqz(cp)
then $UN.p2tr_get(cp) else None(*void*)
//
end // end of [d2var_get_msexp]

(* ****** ****** *)

implement
d2var_set_msexp
  (d2v0, s2e1) = let
//
(*
val () =
println!
("d2var_set_msexp: d2v0 = ", d2v0)
val () =
println!
("d2var_set_msexp: s2e1 = ", s2e1)
*)
//
  val s0 =
  d2v0.stamp()
  val i0 =
  stamp2uint(s0)
  val i0 =
  u2sz(g1ofg0(i0))
  val A0 =
  $UN.castvwtp0{dynarray}(theDynarr)
//
  val () =
  let
  val itm = Some(s2e1)
  in
  dynarray_set_at_exn<itm>(A0, i0, itm)
  end
//
  prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [d2var_set_msexp]

(* ****** ****** *)

implement
stamp_d2var_msexp
  (d2v0) = let
//
(*
val () =
println!
("stamp_d2var_msexp: d2v0 = ", d2v0)
*)
//
val s0 =
d2v0.stamp()
val i0 =
stamp2uint(s0)
val i0 =
u2sz(g1ofg0(i0))
val A0 =
$UN.castvwtp0{dynarray}(theDynarr)
//
val itm = None()
val-
~None_vt() =
dynarray_insert_at_opt(A0, i0, itm)
//
prval((*void*)) = $UN.cast2void(A0)
//
in
  // nothing
end (*let*) // end of [stamp_d2var_msexp]

end // end of [local]

(* ****** ****** *)

(* end of [xats_dynexp2_d2var.dats] *)
