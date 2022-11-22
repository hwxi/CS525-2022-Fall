(* ****** ****** *)
(*
This one is taken from Assignment#4
*)
(* ****** ****** *)

fun
isPrime
(n: int): bool =
loop( 2 ) where
{
fun
loop(i: int): bool =
if
(i*i > n)
then true
else (if n % i = 0 then false else loop(i+1))
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
