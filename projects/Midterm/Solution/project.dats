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
#staload "./project_t1ype.dats"
#staload "./project_t1erm.dats"

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

local
//
static
fun
process_stdin(): void
static
fun
process_fpath(fp0: fpath_t): void
static
fun
process_given(given: string): void
//
(* ****** ****** *)

implement
process_stdin() =
(
  process_fpath(fp0)
) where
{
  val
  fp0 = $FP0.the_filpath_stdin
}
implement
process_fpath(fp0) =
let
//
val
stadyn = 1 // dynamic
//
in//let
//
if
(
stadyn >= 0
)
then
{
val
d0cs =
let
val dpar =
parse_from_filpath_toplevel
  (stadyn, fp0)
in//let
case+
dpar.parsed() of
| Some(d0cs) => d0cs
| None((*void*)) => list_nil()
end : d0eclist // end-of-val
//
val () =
synread_d0eclist(d0cs)
//
val
d1cs = trans01_declist(d0cs)
(*
val () =
println!
("process_fpath: d1cs = ", d1cs)
*)
val () =
tread01_d1eclist(d1cs)
//
val
t1ds = trans1m_d1eclist(d1cs)
val () =
println!
("process_fpath: t1ds = ", t1ds)
//
} (* end of [then] *)
else
{
// ~(stadyn >= 0) // not for loading code
} (* end of [else] *)
//
end // end of [process_fpath]

(* ****** ****** *)

implement
process_given
  (arg0) = let
//
val fp0 =
let
val given = arg0
val fname = arg0
in//let
fpath_make(given, fname)
end (*let*)//end-of-val(fp0)
//
(*
val () =
println!
("process_given: arg0 = ", arg0)
*)
//
in
  process_fpath(fp0)
end // end of [process_given]

in(*in-of-local*)

implement
project_main0
(argc, argv) =
let
//
val
XATSHOME =
"./../../Xanadu"
//
val
((*void*)) =
the_fixity_load(XATSHOME)
//
in
if
(argc = 1)
then process_stdin() else process_given(argv[1])
end // project_main0

end // end of [local]

(* ****** ****** *)
//
implement
main0(argc, argv) =
(
//
if
(argc >= 2)
then project_main0(argc, argv)
else prerrln! ("Hello from CS525(Midterm)!")
// end of [if]
) (* end of [main] *)
//
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project.dats] *)
