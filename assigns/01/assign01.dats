(* ****** ****** *)
(*
HX-2022-09-19:
This assignment asks you to implement
list-based set oprations.
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../mylib/mylib.dats"
(* ****** ****** *)
#include
"./../..\
/lectures/lecture-09-14/lambda0.dats"
(* ****** ****** *)
implement main() = 0 // HX: this is a dummy
(* ****** ****** *)
//
typedef
tvarset = mylist(tvar)
//
(*
HX:
A tvarset is an *ordered* list of tvars
(that is, strings)
*)
(* ****** ****** *)
//
extern
fun FV(t0: term): tvarset
//
(* ****** ****** *)
// 1 point
extern
fun // empty set
tvarset_nil(): tvarset
// 1 point
extern
fun // singleton set
tvarset_sing(v0: tvar): tvarset
// 10 points
extern
fun // delete an element from a set
tvarset_del1(tvarset, tvar): tvarset
// 10 points
extern
fun // form the union of two given sets
tvarset_union(tvarset, tvarset): tvarset

(* ****** ****** *)
//
implement FV(t0) =
(
case t0 of
|
TMint _ => tvarset_nil()
|
TMvar(x0) => tvarset_sing(x0)
|
TMlam(x0, t1) => tvarset_del1(FV(t1), x0)
|
TMapp(t1, t2) => tvarset_union(FV(t1), FV(t2))
)
//
(* ****** ****** *)
//
fun
lam_body
(t0: term): term =
case t0 of
| TMlam(_, t1) => lam_body(t1) | _ => t0
//
(* ****** ****** *)

val omega = TMlam("x", TMapp(x, x))

(* ****** ****** *)

val () =
println!("FV(body(K)) = ", FV(lam_body(K))) // x
val () =
println!("FV(body(S)) = ", FV(lam_body(S))) // x, y, z
val () =
println!("FV(body(K')) = ", FV(lam_body(K'))) // x, y, z
val () =
println!("FV(SKK) = ", FV(TMapp(TMapp(S, K), K))) // empty

(* ****** ****** *)

val () =
println!("FV(body(omega)) = ", FV(lam_body(omega))) // x

(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign01.dats] *)
