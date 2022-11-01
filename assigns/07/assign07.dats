(* ****** ****** *)
(*
Due: Monday, the 7th of November
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
//
typedef ans = void
//
typedef
kont
(res:t@ype) =
(res) -<cloref1> ans
//
(* ****** ****** *)
(*
fun
fact(n: int): int =
if n > 0 then n * fact(n-1) else 1
*)
(* ****** ****** *)
//
extern
fun
kfact
(n: int, k: kont(int)): ans
//
implement
kfact(n, k) =
if
(n <= 0)
then k(1)
else kfact(n-1, lam(res) => k(n * res))
//
val () =
let // HX: testing code for [kfact]
val k0 =
lam(res: int): void =<cloref1> print(res)
in//let
(print("kfact(10) = "); kfact(10, k0); println!())
end // end of [val]
//
(* ****** ****** *)
(*
fun
fibo(n: int): int =
if n >= 2 then fibo(n-2)+fibo(n-1) else n
*)
(* ****** ****** *)
//
(*
HX: 10 points
please implement [kfibo] as a variant
of the above [fibo] function in CPS-style
*)
extern
fun
kfibo
(n: int, k: kont(int)): ans
//
(* ****** ****** *)
//
fun
fact2(n: int): int =
(
  loop(1, 1)) where
{
fun
loop
(i: int, res: int): int =
if
(i <= n)
then loop(i+1, i * res) else res }
//
(* ****** ****** *)
//
(*
HX: 10 points
Please implement [kfact2] as a variant
of the above [fact2] function in CPS-style.
Note that [fact2] is a tail-recursive function.
*)
extern
fun
kfact2
(n: int, k: kont(int)): ans
//
(* ****** ****** *)
implement main0() = () // HX: this is a dummy
(* ****** ****** *)

(* end of [assigns/assign07.dats] *)
