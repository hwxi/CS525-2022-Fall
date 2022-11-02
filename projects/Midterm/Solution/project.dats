//
%{^
//
extern
void
libxatsopt_dynloadall();
//
%} (* %{^ *)
val () =
$extfcall
(void, "libxatsopt_dynloadall")
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"./../../../mylib/mylib.dats"
//
(* ****** ****** *)
//
#include
"./../../HATS/libxatsopt.hats"
//
(* ****** ****** *)

#staload "./project.sats"
(*
#staload "./project_t0erm.dats"
#staload "./project_t1erm.dats"
#staload "./project_t2erm.dats"
*)

(* ****** ****** *)

#dynload "./project_trans.dats"
#dynload "./project_t1ype.dats"
#dynload "./project_t1erm.dats"

(* ****** ****** *)
//
extern
fun
xatsopt_strunq
( source // "<string>" -> <string>
: string): string = "ext#xatsopt_strunq"
//
(* ****** ****** *)
//
extern
fun
the_fixity_load
(
XATSHOME: string
) : void = "ext#libxatsopt_the_fixity_load"
//
(* ****** ****** *)
//
implement
main0(argc, argv) =
(
//
if
(argc >= 2)
then () // project_main0(argc, argv)
else prerrln! ("Hello from CS525(Midterm)!")
// end of [if]
) (* end of [main] *)
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project.dats] *)
