(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../../mylib/mylib.dats"
(* ****** ****** *)
(*
implement
main0 = lam () => ()
*)
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
| TMint of int
| TMbtf of bool
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)
extern
fun
print_term(t0:term): void
extern
fun
fprint_term
(out:FILEref, t0:term): void
(* ****** ****** *)
implement
print_term(t0) =
fprint_term(stdout_ref, t0)
(* ****** ****** *)
implement
fprint_val<term> = fprint_term
(* ****** ****** *)
overload print with print_term
overload fprint with fprint_term
(* ****** ****** *)

implement
fprint_term
(out, t0) =
(
case+ t0 of
|
TMint(i0) =>
fprint!(out, "TMint(", i0, ")")
|
TMbtf(b0) =>
fprint!(out, "TMbtf(", b0, ")")
|
TMvar(v0) =>
fprint!(out, "TMvar(", v0, ")")
|
TMlam(v0, t1) =>
fprint!(out, "TMlam(", v0, ";", t1, ")")
|
TMapp(t1, t2) =>
fprint!(out, "TMapp(", t1, ";", t2, ")")
|
TMopr(nm, ts) =>
fprint!(out, "TMopr(", nm, ";", ts, ")")
|
TMif0(t1, t2, t3) =>
fprint!(out, "TMif0(", t1, ";", t2, ";", t3, ")")
)

(* ****** ****** *)

val x = TMvar("x")
val y = TMvar("y")
val z = TMvar("z")

(* ****** ****** *)

val I = TMlam("x", x)
val K = TMlam("x", TMlam("y", x))
val S = TMlam("x", TMlam("y", TMlam("z", TMapp(TMapp(x, z), TMapp(y, z)))))
val K' = TMlam("x", TMlam("y", y))

(* ****** ****** *)

(*
(* ****** ****** *)
//
HX-2022-09-14:
How to test:
myatscc lambda0.dats && ./lambda0_dats
*)
//
val () = println!("I = ", I)
val () = println!("K = ", K)
val () = println!("S = ", S)
val () = println!("K' = ", K')
//
(* ****** ****** *)
implement main0() = () // HX: it is a dummy
(* ****** ****** *)

extern
fun{}
term_map(t0: term): term
extern
fun{}
term_map_var(t0: term): term
extern
fun{}
term_map_lam(t0: term): term
extern
fun{}
termlst_map(t0: termlst): termlst

(* ****** ****** *)

implement
{}//tmp
term_map
(  t0  ) =
map( t0 ) where
{
fun
map
(t0: term): term =
case+ t0 of
//
| TMint _ => t0
| TMbtf _ => t0
//
|
TMvar _ =>
term_map_var(t0)
|
TMlam(tvar, term) =>
term_map_lam(t0)
|
TMapp(t1, t2) =>
TMapp(map t1, map t2)
//
|
TMopr(topr, ts) =>
TMopr(topr, termlst_map<>(ts))
//
|
TMif0(t1, t2, t3) =>
TMif0( map t1, map t2, map t3 )
} (*where*) // end of [term_map(t0)]

(* ****** ****** *)

implement
{}//tmp
termlst_map(ts) =
(
  maplst(ts)) where
{
fun
maplst(ts: termlst): termlst =
(
case+ ts of
| mylist_nil() =>
  mylist_nil()
| mylist_cons(t1, ts) =>
  mylist_cons(term_map(t1), maplst(ts))
)
} (*where*) // end of [termlst_map(ts)]

(* ****** ****** *)

extern
fun
term_interp(t0: term): term
extern
fun
termlst_interp(ts: termlst): termlst

(* ****** ****** *)

extern
fun
term_subst0
(t0: term, x0: tvar, sub: term): term

(* ****** ****** *)

implement
term_subst0
(t0, x0, sub) =
term_map<>(t0) where
{
//
val () = $tempenver(x0)
val () = $tempenver(sub)
//
implement
term_map_var<>(t0) =
let
  val-TMvar(x1) = t0
in//let
if x0 != x1 then t0 else sub
end//let
//
implement
term_map_lam<>(t0) =
let
  val-TMlam(x1, t1) = t0
in//let
if x0 = x1
then t0 else
TMlam(x1, term_subst0(t1, x0, sub))
end//let
//
} (*where*) // end of [term_subst0]

(* ****** ****** *)

implement
term_interp(t0) =
(
case+ t0 of
//
| TMint _ => t0
| TMbtf _ => t0
//
| TMvar _ => t0
//
| TMlam _ => t0
(*
|
TMlam(x1, t1) =>
TMlam
(x1, term_interp(t1))
*)
//
|
TMapp(t1, t2) =>
let
val t1 = term_interp(t1)
val t2 = term_interp(t2)
in//let
case+ t1 of
|
TMlam(x1, tt) =>
term_interp
(term_subst0(tt, x1, t2))
|
_(*non-TMlam*) => TMapp(t1, t2)
end // let // end of [TMapp]
//
|
TMopr(p1, ts) =>
TMopr(p1, ts) where
{
val ts =
termlst_interp(ts) }
//
|
TMif0(t1, t2, t3) =>
let
val t1 = term_interp(t1)
in//let
case+ t1 of
|
TMbtf(b1) =>
if b1
then term_interp(t2) else term_interp(t3)
|
_(*non-TMbtf*) =>
TMif0(t1, term_interp(t2), term_interp(t3))
end // let // end of [TMif0]
) (* case+ *) // end of [term_interp]

(* ****** ****** *)

implement
termlst_interp(ts) =
(
case+ ts of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_interp(t1), termlst_interp(ts))
)

(* ****** ****** *)

val
SKK = TMapp(TMapp(S, K), K)

val () =
println!("interp(SKK) = ", term_interp(SKK))

(* ****** ****** *)

(* end of [CS525-2022-Fall/mylib/lambda0.dats] *)
