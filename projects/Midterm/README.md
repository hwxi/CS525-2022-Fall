# Midterm for CS525, Fall, 2022

## Abstract Syntax for LAMBDA

### Simple Types

```
datatype t1ype =
//
|
T1Pnil of ()                      // unit type (for T1Mnil)
//
|
T1Pbas of tpbas                   // base types
|
T1Pext of tpVar                   // type variables (for unification)
|
T1Pfun of (t1ype, t1ype)          // fun. types
|
T1Ptup of (t1ype, t1ype)          // tuple types
//
|
T1Plist of (t1ype(*elt*))         // types for lists
//
|
T1Pnone of (s1exp(*unsupported*)) // unsupported features from ATS3/Xanadu
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
| T1Mnil of ()                    // unit
//
| T1Mint of int                   // ints
| T1Mbtf of bool                  // bools
| T1Mstr of string                // strings
//
|
T1Mvar of t1var                   // variables
|
T1Mlam of
(t1var, t1ypeopt, t1erm)          // abstraction
|
T1Mapp of (t1erm, t1erm)          // application
//
|
T1Mopr of
(t1opr, t1ermlst(*arg*))          // primitive ops
//
|
T1Mif0 of
(t1erm, t1erm, t1ermopt)          // if-then-else
//
|
T1Mfst of (t1erm)                 // 1st projection
|
T1Msnd of (t1erm)                 // 2nd projection
|
T1Mtup of (t1erm, t1erm)          // tuples( pairs )
//
|
T1Mseq of (t1ermlst)              // sequencing terms
//
|
T1Mfix of
( t1var
, t1var, t1ypeopt(*arg*)
, t1erm, t1ypeopt(*res*))         // fixed-point for recursion
//
|
T1Mlet of (t1dclist, t1erm)       // let t1dclist in t1erm end
//
|
T1Manno of (t1erm, t1ype(*anno*)) // type annotation: (t1erm: t1ype)
|
T1Mnone of (d1exp(*unsupported*)) // unsupported features from ATS3/Xanadu
//
where t1dclist = mylist(t1dcl)
  and t1ermlst = mylist(t1erm)
  and t1ermopt = myoptn(t1erm)
//
// end of [ datatype(t1dcl,t1erm) ]
```

## Implementation Tasks for this Midterm

### A type-checker for LAMBDA (100 points)
### An interpreter for LAMBDA (100 points)
### Translating programs in LAMBDA into A-normal form (100 points)
### Emitting C code based on programs in A-normal form (100 points)

