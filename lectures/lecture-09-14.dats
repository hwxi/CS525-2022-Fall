(* ****** ****** *)
datatype intlst =
| intlst_nil of ()
| intlst_cons of (int, intlst)
(* ****** ****** *)
#define nil intlst_nil
#define :: intlst_cons
#define cons intlst_cons
(* ****** ****** *)

fun
fprint_intlst
(out: FILEref, xs: intlst): void =
(
case xs of
| intlst_nil() =>
  fprint_string(out, "nil()")
| intlst_cons(x1, xs) =>
(
  fprint_string(out, "cons(");
  fprint_int(out, x1); fprint_string(out, ";");
  fprint_intlst(out, xs); fprint_string(out, ")")
)
)

fun
print_intlst
(xs: intlst): void =
fprint_intlst(stdout_ref, xs)

(* ****** ****** *)

overload print with print_intlst
overload fprint with fprint_intlst

(* ****** ****** *)

val l0 = nil()
val l1 = cons(1, l0)
val l2 = cons(2, l1)
val l3 = 1 :: 2 :: 3 :: nil()

(* ****** ****** *)

val () = println!("Show me something!")

(* ****** ****** *)

val out = stdout_ref
val ( ) = (fprint_string(out, "l2 = "); fprint_intlst(out, l2); fprint_newline(out))
val ( ) = println!("l0 = ", l0)
val ( ) = println!("l1 = ", l1)
val ( ) = println!("l2 = ", l2)
val ( ) = println!("l3 = ", l3)

(* ****** ****** *)

implement main() = 0 // HX: this is a dummy

(* ****** ****** *)

(* end of [CS525-2022-Fall/lectures/lecture-09-14.dats] *)
