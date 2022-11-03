# Midterm for CS525, Fall, 2022

## Abstract Syntax for LAMBDA

### Simple Types

```
datatype t1ype =
//
|
T1Pnil of ()
//
|
T1Pbas of tpbas
|
T1Pext of tpVar
|
T1Pfun of (t1ype, t1ype)
|
T1Ptup of (t1ype, t1ype)
//
|
T1Plist of (t1ype(*elt*))
//
|
T1Pnone of (s1exp(*unsupported*))
//
where
tpbas = string
and
tpVar = ref(myoptn(t1ype))
and t1ypelst = mylist(t1ype)
and t1ypeopt = myoptn(t1ype)
//
// end of [ datatype(t1yp1) ]
```

### Terms (Expressions)

```
(* ****** ****** *)
//
datatype
t1dcl =
|
T1DCLbind of (t1var, t1erm)
(*
|
T1DCLnone of (d1ecl(*unsupported*))
*)
//
and
t1erm =
//
| T1Mnil of ()
//
| T1Mint of int
| T1Mbtf of bool
| T1Mstr of string
//
|
T1Mvar of t1var
|
T1Mlam of
(t1var, t1ypeopt, t1erm)
|
T1Mapp of (t1erm, t1erm)
//
|
T1Mopr of
(t1opr, t1ermlst(*arg*))
//
|
T1Mif0 of
(t1erm, t1erm, t1ermopt)
//
|
T1Mfst of (t1erm)
|
T1Msnd of (t1erm)
|
T1Mtup of (t1erm, t1erm)
//
|
T1Mseq of (t1ermlst)
//
|
T1Mfix of
( t1var
, t1var, t1ypeopt(*arg*)
, t1erm, t1ypeopt(*res*))
//
|
T1Mlet of (t1dclist, t1erm)
//
|
T1Manno of (t1erm, t1ype(*anno*))
|
T1Mnone of (d1exp(*unsupported*))
//
where t1dclist = mylist(t1dcl)
  and t1ermlst = mylist(t1erm)
  and t1ermopt = myoptn(t1erm)
//
// end of [ datatype(t1dcl,t1erm) ]
(* ****** ****** *)
```
