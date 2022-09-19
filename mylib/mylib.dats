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
print_myoptn
(opt: myoptn(a)): void
extern
fun
{a:t@ype}
print_mylist
(opt: mylist(a)): void
//
extern
fun
{a:t@ype}
fprint_myoptn
( out: FILEref
, opt: myoptn(a)): void
//
extern
fun
{a:t@ype}
fprint_mylist
( out: FILEref
, opt: mylist(a)): void
extern
fun{}
fprint_mylist_sep
(  out: FILEref  ): void
//
overload print with print_myoptn
overload print with print_mylist
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
implement
{a}(*tmp*)
print_myoptn(opt) =
fprint_myoptn<a>(stdout_ref, opt)
implement
{a}(*tmp*)
fprint_myoptn
(out, opt) =
(
case+ opt of
|
myoptn_nil() =>
fprint!(out, "none(", ")")
|
myoptn_cons(x0) =>
( fprint(out, "some(");
  fprint_val<a>(out, x0); fprint(out, ")")))
//
(* ****** ****** *)
implement
{a}(*tmp*)
print_mylist(xs) =
fprint_mylist<a>(stdout_ref, xs)
implement
{a}
fprint_mylist
(out, xs) =
loop(xs, 0) where
{
fun
loop
(xs: mylist(a), i0: int): void =
(
case+ xs of
|
mylist_nil() => ()
|
mylist_cons(x1, xs) =>
(if i0 > 0
 then fprint_mylist_sep<>(out);
 fprint_val<a>(out, x1); loop(xs, i0+1)))
} (* end of [fprint_mylist(out, xs)] *)

(* ****** ****** *)
implement
{(*tmp*)}
fprint_mylist_sep(out) = fprint(out, "; ")
(* ****** ****** *)

(*
implement
{a}//tmp
mylist_length(xs) =
(
case xs of
| mylist_nil() => 0
| mylist_cons(_, xs) => 1 + mylist_length<a>(xs)
)
*)
implement
{a}//tmp
mylist_length(xs) =
helper(xs, 0) where
{
fun
helper
(xs: mylist(a), acc: int): int =
(
case xs of
| mylist_nil() => acc
| mylist_cons(_, xs) => helper(xs, acc+1)
)
}

(* ****** ****** *)

(* end of [CS525-2022-Fall/mylib/mylib.dats] *)
