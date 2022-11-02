(*
** For your
** Midterm project
*)

(* ****** ****** *)
//
#staload
"./../../../mylib/mylib.dats"
//
(* ****** ****** *)
//
#include
"./../../HATS/libxatsopt.hats"
//
(* ****** ****** *)
//
datatype t1ype =
//
|
T1Pnil of ()
//
|
T1Pbas of tpbas
|
T1Pext of tpVar
|
T1Pfun of (t1ype, t1ype)
|
T1Ptup of (t1ype, t1ype)
|
T1Pnone of (s1exp(*unsupported*))
//
where
tpbas = string
and
tpVar = ref(myoptn(t1ype))
and t1ypelst = mylist(t1ype)
and t1ypeopt = myoptn(t1ype)
//
(* ****** ****** *)
//
val T1Pint: t1ype
val T1Pbool: t1ype
val T1Punit: t1ype
val T1Pstring: t1ype
//
(* ****** ****** *)
//
fun
print_t1ype(t1ype): void
fun
fprint_t1ype
(out:FILEref, t1p0:t1ype): void
//
overload print with print_t1ype
overload fprint with fprint_t1ype
//
(* ****** ****** *)
//
(*
HX-2022-11-01:
[ctype] for primitive operators
*)
datatype ctype =
CTYPE of (t1ypelst, t1ype)
//
(* ****** ****** *)
//
fun
print_ctype(ctype): void
fun
fprint_ctype
(out:FILEref, ct1p:ctype): void
//
overload print with print_ctype
overload fprint with fprint_ctype
//
(* ****** ****** *)
typedef t1opr = string
typedef t1var = string
(* ****** ****** *)
//
datatype
t1dcl =
|
T1Dbind of (t1var, t1erm)
|
T1Dnone of (d1ecl(*unsupported*))
//
and
t1erm =
//
| T1Mint of int
| T1Mbtf of bool
| T1Mstr of string
//
| T1Mvar of t1var
| T1Mlam of (t1var, t1erm)
| T1Mapp of (t1erm, t1erm)
//
|
T1Mopr of
(t1opr, t1ermlst(*arg*))
//
|
T1Mif0 of
(t1erm, t1erm, t1ermopt)
//
|
T1Mlet of (t1dclist, t1erm)
//
|
T1Manno of (t1erm, t1ype(*anno*))
|
T1Mnone of (d1exp(*unsupported*))
//
where t1dclist = mylist(t1dcl)
  and t1ermlst = mylist(t1erm)
  and t1ermopt = myoptn(t1erm)
//
(* ****** ****** *)
//
fun
print_t1dcl(t1dcl): void
fun
fprint_t1dcl
(out:FILEref, d1cl:t1dcl): void
//
overload print with print_t1dcl
overload fprint with fprint_t1dcl
//
(* ****** ****** *)
//
fun
print_t1erm(t1erm): void
fun
fprint_t1erm
(out:FILEref, t1m0:t1erm): void
//
overload print with print_t1erm
overload fprint with fprint_t1erm
//
(* ****** ****** *)
//
fun
trans1m_s1exp: s1exp -> t1ype
fun
trans1m_s1explst: s1explst -> t1ypelst
fun
trans1m_s1expopt: s1expopt -> t1ypeopt
//
(* ****** ****** *)
//
fun
trans1m_d1exp: d1exp -> t1erm
fun
trans1m_d1explst: d1explst -> t1ermlst
fun
trans1m_d1expopt: d1expopt -> t1ermopt
//
(* ****** ****** *)
//
fun
trans1m_d1ecl: d1ecl -> t1dcl
fun
trans1m_d1eclist: d1eclist -> t1dclist
//
(* ****** ****** *)
//
fun
project_main0
{n:int | n >= 1}(int(n), !argv(n)): void
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project.sats] *)
