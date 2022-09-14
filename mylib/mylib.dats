(* ****** ****** *)
//
(*
HX-2022-09-13:
Some library functions
for BU CAS CS 525 (2022F)
*)
//
(* ****** ****** *)
datatype
myoptn(a:t@ype) =
| myoptn_nil of ()
| myoptn_cons of (a)
(* ****** ****** *)
datatype
mylist(a:t@ype) =
| mylist_nil of ()
| mylist_cons of (a, mylist(a))
(* ****** ****** *)
#define none myoptn_nil
#define some myoptn_cons
(* ****** ****** *)
//
extern
fun
{a:t@ype}
fprint_myoptn
( out: FILEref
, opt: myoptn(a)): void
extern
fun
{a:t@ype}
fprint_mylist
( out: FILEref
, opt: mylist(a)): void
//
overload fprint with fprint_myoptn
overload fprint with fprint_mylist
//
(* ****** ****** *)
extern
fun
{a:t@ype}
mylist_sing(x0: a): mylist(a)

(* ****** ****** *)

extern
fun
{a:t@ype}
mylist_length(xs: mylist(a)): int

(* ****** ****** *)

extern
fun
{a:t@ype}
mylist_getopt_at
(xs: mylist(a), i0: int): myoptn(a)

(* ****** ****** *)
extern
fun
{a:t@ype}
mylist_append
(xs: mylist(a), ys: mylist(a)): mylist(a)
(* ****** ****** *)

extern
fun
{a:t@ype}
mylist_reverse(xs: mylist(a)): mylist(a)
extern
fun
{a:t@ype}
mylist_rappend
(xs: mylist(a), ys: mylist(a)): mylist(a)

(* ****** ****** *)

extern
fun
{a:t@ype}
{b:t@ype}
mylist_map
(xs: mylist(a), f0: a -<cloref1> b): mylist(b)

(* ****** ****** *)
(*
HX-2022-09-13:
Implementation should be given below
*)
(* ****** ****** *)

(* end of [CS525-2022-Fall/mylib/mylib.dats] *)
