(* ****** ****** *)
(*
typedef int8 =
(int, (int, (int,
(int, (int, (int, (int, int)))))))
*)
(* ****** ****** *)

val N = 8

(* ****** ****** *)

fun
proj0(tup8) = fst(tup8)
fun
proj1(tup8) = fst(snd(tup8))
fun
proj2(tup8) = fst(snd(snd(tup8)))
fun
proj3(tup8) = fst(snd(snd(snd(tup8))))
fun
proj4(tup8) = fst(snd(snd(snd(snd(tup8)))))
fun
proj5(tup8) = fst(snd(snd(snd(snd(snd(tup8))))))
fun
proj6(tup8) = fst(snd(snd(snd(snd(snd(snd(tup8)))))))
fun
proj7(tup8) = snd(snd(snd(snd(snd(snd(snd(tup8)))))))

(* ****** ****** *)

fun
print_dots
(i: int): void =
if
(i > 0)
then
( print ". "
; print_dots(i-1)) else ()
// end of [print_dots]

fun
print_row1
(i: int): void =
( print_dots(i); print("Q ")
; print_dots(N-i-1); print "\n")

fun
print_board
( board
: (int, (int, (int,
  (int, (int, (int, (int, int)))))))
) : void =
(
  print_row1(proj0(board))
; print_row1(proj1(board))
; print_row1(proj2(board))
; print_row1(proj3(board))
; print_row1(proj4(board))
; print_row1(proj5(board))
; print_row1(proj6(board))
; print_row1(proj7(board)); print("\n")
) // end of [print_board]

(* ****** ****** *)

fun
board_get(bdi0) =
let
val bd = fst(bdi0)
val i0 = snd(bdi0)
in // let
if
(i0 = 0) then proj0(bd)
else if
(i0 = 1) then proj1(bd)
else if
(i0 = 2) then proj2(bd)
else if
(i0 = 3) then proj3(bd)
else if
(i0 = 4) then proj4(bd)
else if
(i0 = 5) then proj5(bd)
else if
(i0 = 6) then proj6(bd)
else if
(i0 = 7) then proj7(bd) else ~1
end // end of [board_get(bdi0)]

(* ****** ****** *)

fun
board_set(bdij) =
let
val bd = fst(bdij)
val x0 = proj0(bd)
val x1 = proj1(bd)
val x2 = proj2(bd)
val x3 = proj3(bd)
val x4 = proj4(bd)
val x5 = proj5(bd)
val x6 = proj6(bd)
val x7 = proj7(bd)
val i0 = fst(snd(bdij))
val j0 = snd(snd(bdij))
in//let
if
(i0 = 0)
then
let
val x0 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 1)
then
let
val x1 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 2)
then
let
val x2 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 3)
then
let
val x3 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 4)
then
let
val x4 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 5)
then
let
val x5 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 6)
then
let
val x6 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else
if
(i0 = 7)
then
let
val x7 = j0 in (x0, (x1, (x2, (x3, (x4, (x5, (x6, x7))))))) end
else bd
end // end of [board_set(bdij)]

(* ****** ****** *)
//
fun
abs(i: int): int =
(if i >= 0 then i else ~i)
//
(* ****** ****** *)

fun
safety_test1
(i0j0i1j1): bool =
let
val
i0j0 = fst(i0j0i1j1)
and
i1j1 = snd(i0j0i1j1)
val i0 = fst(i0j0) and j0 = snd(i0j0)
val i1 = fst(i1j1) and j1 = snd(i1j1)
in
if
(j0 = j1)
then false else abs(i0-i1) != abs(j0-j1)
end (*let*) // end of [safety_test1(i0j0i1j1)]

(* ****** ****** *)

fun
safety_test2(i0j0bdi1) =
let
val i0j0 = fst(i0j0bdi1)
val bdi1 = snd(i0j0bdi1)
val i0 = fst(i0j0) and j0 = snd(i0j0)
val bd = fst(bdi1) and i1 = snd(bdi1)
in//let
if
(i1 < 0)
then true else
(
if
safety_test1
( (i0, j0)
, (i1, board_get(bd, i1)))
then
safety_test2((i0, j0),(bd, i1-1)) else false)
end (*let*) // end of [safety_test2(i0j0bdi1)]

(* ****** ****** *)

(*
fun
search(bd0) =
lam(i0: int)=>
lam(j0: int)=>
lam(nsol: int): int =>
(
//
if
(j0 < N)
then // then1
let
val test =
safety_test2((i0, j0), (bd0, i0-1))
in//let
if
test
then // then2
let
val bd1 = board_set(bd0, (i0, j0))
in//let
//
  if
  (i0+1 = N)
  then // then3
  let
  val _ =
  print ("Solution #")
  val _ =
  (print(nsol+1); print(":\n\n"))
  val _ = print_board(bd1)
  in//let
  search(bd0)(i0)(j0+1)(nsol+1)
  end // end of [then3]
  else
  (
  search(bd1)(i0+1)(0(*j*))(nsol))
//
end // end of [then2]
else (search(bd0)(i0)(j0+1)(nsol))
//
end // end of [then1]
else
(
if
(i0 > 0)
then search(bd0)(i0-1)(board_get(bd0, i0-1)+1)(nsol) else nsol
) (* end of [if-then1-else1] *)
//
) (* end of [search(bd0)(i0)(j0)(nsol)] *)
*)

(* ****** ****** *)
//
(*
val nsol =
search(bd0)(0)(0)(0) where
{
val bd0 =
(0, (0, (0, (0, (0, (0, (0, 0))))))) }
*)
//
(* ****** ****** *)

fun
search
(bdijns) =
let
val
bd0 = fst(bdijns)
val
ij0 = fst(snd(bdijns))
val
nsol = snd(snd(bdijns))
//
val i0 = fst(ij0) and j0 = snd(ij0)
//
in//let
//
if
(j0 < N)
then // then1
let
val test =
safety_test2
((i0, j0), (bd0, i0-1))
in//let
//
if
test
then // then2
let
val bd1 = board_set(bd0, (i0, j0))
in//let
//
if
(i0+1 = N)
then // then3
let
  val _ =
  print ("Solution #")
  val _ =
  (print(nsol+1); print(":\n\n"))
  val _ = print_board(bd1)
in//let
  search(bd0, ((i0, j0+1), nsol+1))
end // let // end of [then3]
else
(
search(bd1, ((i0+1, 0(*j*)), nsol)))
//
end // let // end of [then2]
else (search(bd0, ((i0, j0+1), nsol)))
//
end // let // end of [then1]
else // else1
(
if
(i0 <= 0)
then nsol else
search(bd0, ((i0-1, board_get(bd0, i0-1)+1), nsol))
) (* end of [if-then1-else1] *)
//
end (*let*) // end of [search(bdijns)]

(* ****** ****** *)
//
(*
val nsol =
search(bd0)(0)(0)(0) where
{ val bd0 =
  (0, (0, (0, (0, (0, (0, (0, 0))))))) }
*)
//
(* ****** ****** *)
//
val nsol =
search(bd0, ((0, 0), 0)) where
{ val bd0 =
  (0, (0, (0, (0, (0, (0, (0, 0))))))) }
//
(* ****** ****** *)

(* end of [queens.dats] *)

