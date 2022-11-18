(* ****** ****** *)
//
(*
HX-2022-09-13:
Some library functions
for BU CAS CS 525 (2022F)
*)
//
(* ****** ****** *)
//
extern
fun{}
int2str(int): string
//
extern
fun{}
string_append
(string, string): string
//
overload + with string_append
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
extern
castfn
list2mylist
{a:t@ype}(List0(a)): mylist(a)
extern
castfn
option2myoptn
{a:t@ype}(Option(a)): myoptn(a)
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
extern
fun
{a:t@ype}
mylist_pair(x0: a, y0: a): mylist(a)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
mylist_head(xs: mylist(a)): (a)
extern
fun
{a:t@ype}
mylist_tail(xs: mylist(a)): mylist(a)
//
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
mylist_extend
(xs: mylist(a), x0: a): mylist(a)
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
mylist_map_cfr
(xs: mylist(a), f0: a -<cloref1> b): mylist(b)

(* ****** ****** *)
//
extern
fun{}
string2mylist
  (cs: string): mylist(char)
//
(* ****** ****** *)
(*
HX-2022-09-13:
Implementation should be given below
*)
(* ****** ****** *)
//
implement
{}//tmp
int2str(int) =
strptr2string(g0int2string(int))
//
(* ****** ****** *)
//
implement
{}//tmp
string_append(cs1, cs2) =
strptr2string(string0_append<>(cs1, cs2))
//
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
//
implement
{a}//tmp
mylist_sing(x0) =
mylist_cons(x0, mylist_nil())
implement
{a}//tmp
mylist_pair(x0, y0) =
mylist_cons
(x0, mylist_cons(y0, mylist_nil()))
//
(* ****** ****** *)
//
implement
{a}//tmp
mylist_head(xs) =
(case- xs of mylist_cons(x0, xs) => x0)
implement
{a}//tmp
mylist_tail(xs) =
(case- xs of mylist_cons(x0, xs) => xs)
//
(* ****** ****** *)

(*
(*
HX-2022-09-19:
Please avoid this style of
recursive template implementation.
*)
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
//
implement
{a}//tmp
mylist_extend
(xs, x0) = 
mylist_append<a>
(xs, mylist_sing<a>(x0))
//
implement
{a}//tmp
mylist_append
( xs, ys ) =
mylist_rappend<a>
(mylist_reverse<a>(xs), ys)
//
(* ****** ****** *)

implement
{a}//tmp
mylist_reverse
(   xs   ) =
mylist_rappend<a>(xs, mylist_nil())

implement
{a}//tmp
mylist_rappend
( xs, ys ) =
helper(xs, ys) where
{
fun
helper
( xs: mylist(a)
, ys: mylist(a)): mylist(a) =
(
case xs of
| mylist_nil() => ys
|
mylist_cons
( x1 , xs ) => helper(xs, mylist_cons(x1, ys))
)
}

(* ****** ****** *)
//
implement
{a}{b}//tmp
mylist_map_cfr
( xs, f0 ) = map(xs) where
{
fun
map(xs: mylist(a)): mylist(b) =
case+ xs of
|
mylist_nil() => mylist_nil()
|
mylist_cons(x1, xs) => mylist_cons(f0(x1), map(xs))
} (*where*) // end of [ mylist_map_cfr(xs, f0) ]
//
(* ****** ****** *)
implement
{}//tmp
string2mylist(cs) =
list2mylist(list_vt2t(stream2list_vt<char>(streamize_string_char<>(cs))))
(* ****** ****** *)

(* end of [CS525-2022-Fall/mylib/mylib.dats] *)
