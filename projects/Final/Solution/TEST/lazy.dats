(* ****** ****** *)

fun
ints_from
(n0: int): lazy(strm(int)) =
$lazy
(strm_cons(n0, ints_from(n0+1)))

(* ****** ****** *)

fun
sieve
(
xs: lazy(strm(int))
) : lazy(strm(int)) =
$lazy
(
case- $eval(xs) of
|
strm_cons(x0, xs) =>
strm_cons(x0, filter(xs)) where
{
fun filter(xs) =
$lazy(
case- $eval(xs) of
| strm_cons(x1, xs) =>
if
(x1%x0 = 0)
then $eval(filter(xs)) else strm_cons(x1, filter(xs)))
}
)

(* ****** ****** *)
//
fun
ints_print
( xs
: lazy
  (strm(int))): void =
(
auxmain(xs, 0, 10)) where
{
fun
auxmain(xs, i0, n0): void =
if i0 < n0 then
(
case+ $eval(xs) of
|
strm_nil() => print(".")
|
strm_cons(x1, xs) =>
(if i0 > 0 then print(","); print(x1); auxmain(xs, i0+1, n0)))
} (*where*) // end of [ ints_print(xs) ]
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Final_project_TEST_lazy.dats] *)
