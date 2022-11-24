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
xs
: lazy(strm(int))
)
: lazy(strm(int)) = $lazy
let
  val xs = $eval(xs)
  val x0 = strm_uncons1(xs)
  val xs = strm_uncons2(xs)
in//let
(
strm_cons
( x0
, sieve(filter(xs)))) where
{
//
fun
filter(xs) = $lazy
(
let
val xs = $eval(xs)
val x1 = strm_uncons1(xs)
val xs = strm_uncons2(xs)
in//let
if
(x1%x0 = 0)
then $eval(filter(xs))
else strm_cons(x1, filter(xs))
end (*let*) // end-of-[filter(xs)]
) (*$lazy*)
//
} (*where*)
end (*let*) // end of [ sieve(xs) ]

(* ****** ****** *)
//
fun
ints_print
( xs
: lazy
  (strm(int))): void =
(
auxmain(xs)( 0)(99)) where
{
//
fun
auxmain
( xs
: lazy(strm(int))
) =
lam(i0) =>
lam(n0): void =>
if
(i0 >= n0)
then
print(",...") else
(
let
  val xs = $eval(xs)
in
  if
  strm_nilq(xs)
  then
    print( "." )
  else
    let
      val x1 = strm_uncons1(xs)
      val xs = strm_uncons2(xs)
    in
      (if i0 > 0 then print(","); print(x1); auxmain(xs)(i0+1)(n0))
    end
  // end-of-[if]
end
)
//
} (*where*) // end of [ ints_print(xs) ]
//
(* ****** ****** *)

val _ =
(ints_print(ints_from(2)); print("\n")
val _ =
(ints_print(sieve(ints_from(2))); print("\n"))

(* ****** ****** *)

(* end of [CS525-2022-Fall/Final_project_TEST_lazy.dats] *)
