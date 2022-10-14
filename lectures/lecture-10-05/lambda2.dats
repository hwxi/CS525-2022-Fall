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
//
typedef tbas = string
//
(* ****** ****** *)
//
datatype type =
//
|
TPbas of tbas
|
TPfun of (type, type)
|
TPtup of (type, type)
//
where typelst = mylist(type)
//
(* ****** ****** *)
val TPint = TPbas("int")
val TPbtf = TPbas("bool")
val TPstr = TPbas("string")
(* ****** ****** *)
extern
fun
print_type(type): void
extern
fun
fprint_type
(out:FILEref, tp:type): void
(* ****** ****** *)
implement
print_type(tp) =
fprint_type(stdout_ref, tp)
(* ****** ****** *)
implement
fprint_val<type> = fprint_type
(* ****** ****** *)
overload print with print_type
overload fprint with fprint_type
(* ****** ****** *)
implement
fprint_type
(out, tp) =
(
case+ tp of
|
TPbas(nm) =>
fprint!(out, "TPbas(", nm, ")")
|
TPfun(tp1, tp2) =>
fprint!(out, "TPfun(", tp1, ";", tp2, ")")
|
TPtup(tp1, tp2) =>
fprint!(out, "TPtup(", tp1, ";", tp2, ")")
)
(* ****** ****** *)
//
extern
fun
type_equal
(t1: type, t2: type): bool
overload = with type_equal
//
(* ****** ****** *)
//
implement
type_equal
( t1, t2 ) =
(
case+ t1 of
|
TPbas(nm1) =>
(case+ t2 of
|
TPbas(nm2) => (nm1 = nm2) | _ => false)
|
TPfun(t11, t12) =>
(case+ t2 of
|
TPfun(t21, t22) =>
( t11 = t21 && t12 = t22 ) | _ => false)
|
TPtup(t11, t12) =>
(case+ t2 of
|
TPtup(t21, t22) =>
( t11 = t21 && t12 = t22 ) | _ => false)
)
//
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
| TMfix of
  (tvar(*f*), tvar(*x*), term)
//
| TMlam2 of
  (tvar, type, term)
| TMfix2 of
  (tvar(*f*), tvar(*x*), type, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)

typedef tctx = mylist(@(tvar, type))

(* ****** ****** *)
//
extern
fun
term_oftype0(term): type
extern
fun
term_oftype1(term, tctx): type
extern
fun
term_oftype1_var(term, tctx): type
extern
fun
term_oftype1_opr(term, tctx): type
//
extern
fun
termlst_oftype1
(ts: termlst, xts: tctx): typelst
//
(* ****** ****** *)

implement
term_oftype0(t0) =
term_oftype1( t0, mylist_nil())

(* ****** ****** *)

implement
term_oftype1
(  t0, xts  ) =
(
case+ t0 of
| TMint _ => TPint
| TMbtf _ => TPbtf
| TMstr _ => TPstr
| TMvar _ => term_oftype1_var(t0, xts)
//
|
TMlam _ =>
let
val () =
assertloc(false) in TPbas("")
end
|
TMfix _ =>
let
val () =
assertloc(false) in TPbas("")
end
//
|
TMapp(t1, t2) =>
let
val tp1 =
term_oftype1(t1, xts)
val tp2 =
term_oftype1(t2, xts)
val-
TPfun(tp11, tp12) = tp1
val-true = ( tp11 = tp2 ) in tp12
end // let // end of [TPapp(t1, t2)]
//
|
TMopr _ =>
term_oftype1_opr(t0, xts)
//
|
TMif0(t1, t2, t3) =>
let
val tp1 =
term_oftype1(t1, xts)
val tp2 =
term_oftype1(t2, xts)
val tp3 =
term_oftype1(t3, xts)
val-
true = ( tp1 = TPbtf )
val-true = ( tp2 = tp3 ) in tp2 end
//
|
TMlam2(x1, tp1, t1) =>
(
  TPfun(tp1, tp2) ) where
{
val tp2 =
term_oftype1
(t1, mylist_cons(@(x1, tp1), xts)) }
//
|
TMfix2
(f1, x1, tp1, t1) => tp1 where
{
val-
TPfun(tp11, tp12) = tp1
val tp22 =
term_oftype1
(t1, mylist_cons(@(f1, tp1), mylist_cons(@(x1, tp11), xts)))
val-true = ( tp12 = tp22 ) }
//
) (*case+*) // end of [term_oftype1(t0,xts)]

(* ****** ****** *)

implement
term_oftype1_var
(t0, xts) =
let
val-TMvar(x) = t0
in
find(xts) where
{
fun find(xts: tctx): type =
(
case- xts of
| mylist_cons(xt, xts) =>
  (if x = xt.0 then xt.1 else find(xts))
)
}
end (*let*) // end of [term_oftype1_var]

(* ****** ****** *)
//
implement
term_oftype1_opr
(t0, xts) =
let
//
val-TMopr(p1, ts) = t0
val tps = termlst_oftype1(ts, xts)
//
in//let
(
case- p1 of
//
| "+" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPint end
//
| "-" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPint end
//
| "*" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPint end
//
| ">" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
| "<" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
| "=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
| ">=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
| "<=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
| "!=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = (tp1 = TPint)
val-true = (tp2 = TPint) in TPbtf end
//
)
end // let // end of [term_oftype1_opr]
//
(* ****** ****** *)

implement
termlst_oftype1(ts, xts) =
(
case+ ts of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_oftype1(t1, xts), termlst_oftype1(ts, xts))
)

(* ****** ****** *)

datatype value =
//
| VALint of int
| VALbtf of bool
| VALstr of string
//
| VALlam of (term, venv)
| VALfix of (term, venv)
//
where
venv = mylist(@(tvar, value))

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
VALlam(t0, venv) =>
fprint!(out, "VALlam(", "...", ")")
|
VALfix(t0, venv) =>
fprint!(out, "VALfix(", "...", ")")
)
(* ****** ****** *)

extern
fun
term_interp0(t0: term): value
extern
fun
term_interp1
(t0: term, xvs: venv): value
extern
fun
term_interp1_var
(t0: term, xvs: venv): value
extern
fun
term_interp1_opr
(t0: term, xvs: venv): value
extern
fun
termlst_interp1
(ts: termlst, xvs: venv): valuelst

(* ****** ****** *)

implement
term_interp0(t0) =
term_interp1(t0, mylist_nil())

implement
term_interp1(t0, xvs) =
(
case+ t0 of
//
| TMint(i0) => VALint(i0)
| TMbtf(b0) => VALbtf(b0)
| TMstr(s0) => VALstr(s0)
//
|
TMvar _ =>
term_interp1_var(t0, xvs)
//
|
TMlam _ => VALlam(t0, xvs)
|
TMfix _ => VALfix(t0, xvs)
//
|
TMapp(t1, t2) =>
let
val v1 = term_interp1(t1, xvs)
val v2 = term_interp1(t2, xvs)
in//let
case- v1 of
|
VALlam(TMlam(x1, tt), xvs) =>
term_interp1
(tt, mylist_cons(@(x1, v2), xvs))
|
VALfix(TMfix(f1, x1, tt), xvs) =>
term_interp1
(tt, mylist_cons(@(f1, v1), mylist_cons(@(x1, v2), xvs)))
end // let // end of [TMapp]
//
|
TMopr _ => term_interp1_opr(t0, xvs)
//
|
TMif0(t1, t2, t3) =>
let
val v1 = term_interp1(t1, xvs)
in//let
case- v1 of
|
VALbtf(b1) =>
if b1 then term_interp1(t2, xvs)
      else term_interp1(t3, xvs)
end // let // end of [TMif0]
//
|
TMlam2
(x1, tp, t1) => VALlam(TMlam(x1, t1), xvs)
|
TMfix2
(f1, x1, tp, t1) => VALfix(TMfix(f1, x1, t1), xvs)
//
) (* case+ *) // end of [term_interp1(t0, xvs)]

(* ****** ****** *)

implement
termlst_interp1(ts, xvs) =
(
case+ ts of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_interp1(t1, xvs), termlst_interp1(ts, xvs))
)

(* ****** ****** *)

implement
term_interp1_var
(t0, xvs) =
let
val-TMvar(x) = t0
in
find(xvs) where
{
fun find(xvs: venv): value =
(
case- xvs of
| mylist_cons(xv, xvs) =>
  (if x = xv.0 then xv.1 else find(xvs))
)
}
end (*let*) // end of [term_interp1_var]

(* ****** ****** *)

implement
term_interp1_opr
(t0, xvs) =
let
//
val-TMopr(p1, ts) = t0
val vs = termlst_interp1(ts, xvs)
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
end (*let*) // end of [term_interp1_opr]

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
TMfix2("f", "m", TPfun(TPint, TPint),
TMif0(TMgt(m, TMint(0)), TMadd(m, TMapp(f, TMsub(m, TMint(1)))), TMint(0))) where
{
  val f = TMvar("f")
  val m = TMvar("m")
}

(* ****** ****** *)

val () =
println!("mysum2: ", term_oftype0(mysum2))
val () =
println!("mysum2(100) = ", term_interp0(TMapp(mysum2, TMint(100))))

(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-05/lambda2.dats] *)
