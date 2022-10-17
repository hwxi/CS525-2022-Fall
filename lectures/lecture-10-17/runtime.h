/*
// A basic runtime for lambda
*/

/* ****** ****** */

#include <stdio.h>
#include <stdlib.h>

/* ****** ****** */

extern
void*
mymalloc(size_t);

/* ****** ****** */

#define TAGint 1
#define TAGstr 2
#define TAGcfp 3 // closure-function-pointer

/* ****** ****** */

/*
typedef
lamval0 =
struct{ int tag; }
*/
typedef
struct{ int tag; } lamval0;

/* ****** ****** */

typedef lamval1 *lamval0;

/* ****** ****** */

int
LAMVAL_tag
(lamval x){ return x->tag; }

/* ****** ****** */

typedef
struct{
  int tag; int data;
} lamval0_int;
typedef
struct{
  int tag; str data;
} lamval0_str;

typedef lamval1_int *lamval0_int;
typedef lamval1_str *lamval0_str;

/* ****** ****** */

extern
lamval
LAMVAL_int(int i);

/* ****** ****** */

extern
lamval
LAMOPR_add(lamval x, lamval y);

/* ****** ****** */

extern
lamval
LAMOPR_sub(lamval x, lamval y);

/* ****** ****** */

extern
lamval
LAMOPR_mul(lamval x, lamval y);

/* ****** ****** */

extern
lamval
LAMOPR_ilt(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval_int)x)->data < ((lamval_int)y)->data ? 1 : 0);
}

extern
lamval
LAMOPR_ile(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);ppp
  */
  return
  LAMVAL_int(((lamval_int)x)->data <= ((lamval_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval
LAMOPR_igt(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);ppp
  */
  return
  LAMVAL_int(((lamval_int)x)->data > ((lamval_int)y)->data ? 1 : 0);
}

extern
lamval
LAMOPR_ige(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);ppp
  */
  return
  LAMVAL_int(((lamval_int)x)->data >= ((lamval_int)y)->data ? 1 : 0);
}

/* ****** ****** */

