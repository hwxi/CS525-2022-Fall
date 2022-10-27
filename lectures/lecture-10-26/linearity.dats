(* ****** ****** *)
absvtype cake
(* ****** ****** *)

extern
fun cake_make(): cake

extern
fun eat(cake): void

(* ****** ****** *)

extern
fun look_at(!cake): void

(* ****** ****** *)
//
val
cake1 = cake_make()
val
cake2 = cake_make()
val () = look_at(cake1)
val () = look_at(cake1)
val () = eat(cake1)
(*
val () = eat(cake1) // no double eat!!!
*)
val () = eat(cake2)
//
(* ****** ****** *)

(* end of [linearity.dats] *)
