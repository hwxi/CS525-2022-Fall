(* ****** ****** *)
(*
This one is taken from Assignment#4
*)
(* ****** ****** *)

fun
isPrime
(n: int): bool =
loop(n,2) where
{
fun
loop
(ni: (int, int)): bool =
let
val n = fst(ni)
val i = snd(ni)
in
if
(i*i > n)
then true else
(if n % i = 0 then false else loop(n, i+1))
end (*let*) // end of [loop(ni)]
}

(* ****** ****** *)

val _ =
(
print("isPrime(11) = "); print(isPrime(11)); print("\n")
)
val _ =
(
print("isPrime(101) = "); print(isPrime(101)); print("\n")
)
val _ =
(
print("isPrime(1001) = "); print(isPrime(1001)); print("\n")
)

(* ****** ****** *)

(* end of [isPrime.dats] *)
