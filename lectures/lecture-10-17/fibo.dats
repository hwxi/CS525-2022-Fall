(*
HX-2022-10-17:
A demo of program verification
*)
(*
FIB(n, r):  fib(n) = r
*)
(*
FIB1: () => FIB(0, 1)
FIB2: () => FIB(1, 1)
FIB3: (FIB(n, r0), FIB(n+1, r1)) => FIB(n+2, r0+r1)
*)
dataprop
FIB(int, int) =
// FIB1: () => FIB(0, 0)
| FIB1(0, 0) of ()
// FIB2: () => FIB(1, 1)
| FIB2(1, 1) of ()
// FIB3: (FIB(n, r0), FIB(n+1, r1)) => FIB(n+2, r0+r1)
|
{n:nat}
{r0,r1:int}
FIB3(n+2, r0+r1) of
(FIB(n, r0), FIB(n+1, r1))

(* ****** ****** *)

extern
fun
fibo{n:nat}
(x: int(n)): [r:int] (FIB(n, r) | int(r))

(* ****** ****** *)

implement
fibo(x) =
if x = 0
then (FIB1() | 0)
else
if x = 1
then (FIB2() | 1)
else
let
val (f0 | r0) = fibo(x-2)
val (f1 | r1) = fibo(x-1)
in
  (FIB3(f0, f1) | r0 + r1)
end

(* ****** ****** *)

(* end of [lectures/lecture-10-17/fibo.dats] *)
