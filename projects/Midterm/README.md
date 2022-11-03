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
// end of [datatype t1yp1]
```

### Terms (Expressions)