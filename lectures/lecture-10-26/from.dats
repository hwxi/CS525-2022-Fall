#include
"share/atspre_staload.hats"
(* ****** ****** *)

fun
from(n:int): stream(int) =
$delay(stream_cons(n, from(n+1)))

fun
sieve(xs: stream(int)): stream(int) =
$delay
(
let
  val-stream_cons(x1, xs) = !xs
in
  stream_cons(x1, sieve(filter(xs, x1)))
end
)

and
filter(xs: stream(int), x1: int): stream(int) =
$delay
(
let
val-stream_cons(x2, xs) = !xs in
if x2 % x1 = 0 then !(filter(xs, x1)) else stream_cons(x2, filter(xs, x1))
end
)

val xs = sieve(from(2))
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)
val-
stream_cons(x, xs) = !xs
val () = println!("x = ", x)


implement main0() = ()

