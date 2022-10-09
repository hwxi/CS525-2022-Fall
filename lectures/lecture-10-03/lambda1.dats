(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../../mylib/mylib.dats"
(* ****** ****** *)
implement
main0 = lam () => ()
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
| TMint of int
| TMbtf of bool
| TMstr of string
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
| TMfix of (tvar(*f*), tvar(*x*), term)
//
where termlst = mylist(term)
//
(* ****** ****** *)

datatype value =
//
| VALint of int
| VALbtf of bool
| VALstr of string
//
| VALlam of (term, env_t)
| VALfix of (term, env_t)
//
where
env_t = mylist(@(tvar, value))

typedef valuelst = mylist(value)

(* ****** ****** *)
extern
fun
print_value(value): void
extern
fun
fprint_value
(out:FILEref, v0:value): void
(* ****** ****** *)
implement
print_value(v0) =
fprint_value(stdout_ref, v0)
(* ****** ****** *)
implement
fprint_val<value> = fprint_value
(* ****** ****** *)
overload print with print_value
overload fprint with fprint_value
(* ****** ****** *)
implement
fprint_value
(out, v0) =
(
case+ v0 of
|
VALint(i0) =>
fprint!(out, "VALint(", i0, ")")
|
VALbtf(b0) =>
fprint!(out, "VALbtf(", b0, ")")
|
VALstr(s0) =>
fprint!(out, "VALstr(", s0, ")")
|
VALlam(t0, env) =>
fprint!(out, "VALlam(", "...", ")")
|
VALfix(t0, env) =>
fprint!(out, "VALfix(", "...", ")")
)
(* ****** ****** *)

extern
fun
term_interp0(t0: term): value
extern
fun
term_interp1
(t0: term, env: env_t): value
extern
fun
term_interp1_var
(t0: term, env: env_t): value
extern
fun
term_interp1_opr
(t0: term, env: env_t): value
extern
fun
termlst_interp1
(ts: termlst, env: env_t): valuelst

(* ****** ****** *)

implement
term_interp0(t0) =
term_interp1(t0, mylist_nil())

implement
term_interp1(t0, env) =
(
case+ t0 of
//
| TMint(i0) => VALint(i0)
| TMbtf(b0) => VALbtf(b0)
| TMstr(s0) => VALstr(s0)
//
|
TMvar _ =>
term_interp1_var(t0, env)
//
|
TMlam _ => VALlam(t0, env)
|
TMfix _ => VALfix(t0, env)
//
|
TMapp(t1, t2) =>
let
val v1 = term_interp1(t1, env)
val v2 = term_interp1(t2, env)
in//let
case- v1 of
|
VALlam(TMlam(x1, tt), env) =>
term_interp1(tt, mylist_cons(@(x1, v2), env))
|
VALfix(TMfix(f1, x1, tt), env) =>
term_interp1(tt, mylist_cons(@(f1, v1), mylist_cons(@(x1, v2), env)))
end // let // end of [TMapp]
//
|
TMopr _ => term_interp1_opr(t0, env)
//
|
TMif0(t1, t2, t3) =>
let
val v1 = term_interp1(t1, env)
in//let
case- v1 of
|
VALbtf(b1) =>
if b1
then term_interp1(t2, env)
else term_interp1(t3, env)
end // let // end of [TMif0]
//
) (* case+ *) // end of [term_interp1(t0, env)]

(* ****** ****** *)

implement
termlst_interp1(ts, env) =
(
case+ ts of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_interp1(t1, env), termlst_interp1(ts, env))
)

(* ****** ****** *)

implement
term_interp1_var
(t0, env) =
let
val-TMvar(x) = t0
in
find(env) where
{
  fun find(env: env_t): value =
  (
  case- env of
  | mylist_cons(xv, env) => (if x = xv.0 then xv.1 else find(env))
  )
}
end (*let*) // end of [term_interp1_var]

(* ****** ****** *)

implement
term_interp1_opr
(t0, env) =
let
//
val-TMopr(p1, ts) = t0
val vs = termlst_interp1(ts, env)
//
in//let
(
case- p1 of
//
| "+" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALint(i1+i2)
end
| "-" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALint(i1-i2)
end
| "*" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALint(i1*i2)
end
//
| "<" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 < i2)
end
| ">" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 > i2)
end
| "=" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 = i2)
end
| "<=" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 <= i2)
end
| ">=" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 >= i2)
end
| "!=" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
val-
VALint(i1) = v1 and VALint(i2) = v2 in VALbtf(i1 != i2)
end
//
)
end (*let*) // end of [term_interp_opr]

(* ****** ****** *)
//
fun
TMadd // addition
(x: term, y: term): term =
TMopr("+", mylist_pair(x, y))
fun
TMsub // subtraction
(x: term, y: term): term =
TMopr("-", mylist_pair(x, y))
fun
TMmul // multiplication
(x: term, y: term): term =
TMopr("*", mylist_pair(x, y))
//
fun
TMlt // less
(x: term, y: term): term =
TMopr("<", mylist_pair(x, y))
fun
TMgt // greater
(x: term, y: term): term =
TMopr(">", mylist_pair(x, y))
fun
TMlte // less-equal
(x: term, y: term): term =
TMopr("<=", mylist_pair(x, y))
fun
TMgte // greater-equal
(x: term, y: term): term =
TMopr(">=", mylist_pair(x, y))
//
fun
TMeq // equal
(x: term, y: term): term =
TMopr("=", mylist_pair(x, y))
fun
TMneq // not-equal
(x: term, y: term): term =
TMopr("!=", mylist_pair(x, y))
//
(* ****** ****** *)
//
fun
Theta() =
TMapp(wxy, wxy) where
{
//
val x = TMvar("x")
val y = TMvar("y")
val z = TMvar("z")
//
val wxy =
TMlam("x", TMlam("y", TMapp(y, TMlam("z", TMapp(TMapp(TMapp(x, x), y), z)))))
//
}(*where*)//end-of-[fun Theta()]
//
(* ****** ****** *)

val
mysum =
TMapp
(
Theta(),
(
TMlam("f",
TMlam("m",
TMif0(TMgt(m, TMint(0)), TMadd(m, TMapp(f, TMsub(m, TMint(1)))), TMint(0))))) where
{
  val f = TMvar("f")
  val m = TMvar("m")
}
)

(* ****** ****** *)

val () =
println!("mysum(100) = ", term_interp0(TMapp(mysum, TMint(100))))

(* ****** ****** *)

val
mysum2 =
TMfix("f", "m",
TMif0(TMgt(m, TMint(0)), TMadd(m, TMapp(f, TMsub(m, TMint(1)))), TMint(0))) where
{
  val f = TMvar("f")
  val m = TMvar("m")
}

(* ****** ****** *)

val () =
println!("mysum2(100) = ", term_interp0(TMapp(mysum2, TMint(100))))

(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-03/lambda1.dats] *)
