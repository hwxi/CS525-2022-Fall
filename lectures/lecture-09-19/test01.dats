(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../../mylib/mylib.dats"
(* ****** ****** *)
implement main0() = ()
(* ****** ****** *)
val xs =
mylist_cons
(1, mylist_cons(2, mylist_cons(3, mylist_nil())))
val () =
println!("head(", xs, ") = ", mylist_head<int>(xs))
val () =
println!("tail(", xs, ") = ", mylist_tail<int>(xs))
val () =
println!("length(", xs, ") = ", mylist_length<int>(xs))
(* ****** ****** *)

(* end of [test01.dats] *)
