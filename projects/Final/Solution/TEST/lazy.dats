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
let
val xs = $eval(xs)
vla x0 = strm_uncons1(xs)
vla xs = strm_uncons2(xs)
in//let
strm_cons(x0, filter(xs))
end (*let*)
) where
{
//
fun
filter(xs) =
$lazy(
let
val xs = $eval(xs)
val x1 = strm_uncons1(xs)
val xs = strm_uncons2(xs)
in
if
(x1%x0 = 0)
then $eval(filter(xs)) else strm_cons(x1, filter(xs))
end (*let*)
) (*$lazy*) // end of [filter(xs)]
//
} (*where*) // end of [ sieve(xs) ]

(* ****** ****** *)
//
fun
ints_print
( xs
: lazy
  (strm(int))): void =
(
auxmain(xs)( 0)(10)) where
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
(i0 < n0)
then
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
      if i0 > 0 then (print(","); print(x1); auxmain(xs)(i0+1)(n0))
    end
  // end-of-[if]
end
)
//
} (*where*) // end of [ ints_print(xs) ]
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Final_project_TEST_lazy.dats] *)
