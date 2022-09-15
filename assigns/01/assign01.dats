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

typedef
tvarset = mylist(tvar)

(* ****** ****** *)

extern
fun
FV(t0: term): tvarset

(* ****** ****** *)

extern
fun
tvarset_nil(): tvarset
extern
fun
tvarset_sing(v0: tvar): tvarset
extern
fun
tvarset_del1(tvarset, tvar): tvarset
extern
fun
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

val () =
println!("FV(body(K)) = ", FV(lam_body(K)))
val () =
println!("FV(body(S)) = ", FV(lam_body(S)))
val () =
println!("FV(SKK) = ", FV(TMapp(TMapp(S, K), K)))

(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign01.dats] *)
