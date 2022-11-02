(* ****** ****** *)
//
#define
XANADU_targetloc "./../Xanadu"
//
(* ****** ****** *)
//
#staload
ERR =
"{$XANADU}/srcgen1/SATS/xerrory.sats"
//
(* ****** ****** *)
//
#staload
STM =
"{$XANADU}/srcgen1/SATS/xstamp0.sats"
#staload
SYM =
"{$XANADU}/srcgen1/SATS/xsymbol.sats"
//
(* ****** ****** *)
//
#staload
FP0 =
"{$XANADU}/srcgen1/SATS/filpath.sats"
//
  typedef
  fpath_t = $FP0.filpath
  macdef
  dirbase =
  $FP0.filpath_dirbase
  macdef
  fpath_make = $FP0.filpath_make
//
(* ****** ****** *)
//
#staload
GLO =
"{$XANADU}/srcgen1/SATS/xglobal.sats"
#staload
FS0 =
"{$XANADU}/srcgen1/SATS/filsrch.sats"
//
(* ****** ****** *)
//
#staload
"{$XANADU}/srcgen1/SATS/xbasics.sats"
//
#staload
"{$XANADU}/srcgen1/SATS/lexing0.sats"
//
#staload
"{$XANADU}/srcgen1/SATS/parsing.sats"
//
#staload
"{$XANADU}/srcgen1/SATS/synread.sats"
//
#staload
"{$XANADU}/srcgen1/SATS/staexp1.sats"
#staload
"{$XANADU}/srcgen1/SATS/dynexp1.sats"
//
#staload
"{$XANADU}/srcgen1/SATS/trans01.sats"
#staload
"{$XANADU}/srcgen1/SATS/tread01.sats"
//
(* ****** ****** *)
//
#staload
_(*TMP*) =
"{$XANADU}/srcgen1/DATS/staexp0_print0.dats"
#staload
_(*TMP*) =
"{$XANADU}/srcgen1/DATS/dynexp0_print0.dats"
//
#staload
_(*TMP*) =
"{$XANADU}/srcgen1/DATS/staexp1_print0.dats"
#staload
_(*TMP*) =
"{$XANADU}/srcgen1/DATS/dynexp1_print0.dats"
//
(* ****** ****** *)

(* end of [projects/Midterm/Xanadu_libxatsopt.hats] *)

