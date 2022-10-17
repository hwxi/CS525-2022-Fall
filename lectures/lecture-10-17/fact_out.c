/* ****** ****** */

#include "runtime.h"

/* ****** ****** */

extern
void*
mymalloc(size_t n) {
  void* p0;
  p0 = malloc(n);
  if (p0 != 0) return p0;
  fprintf(stderr, "myalloc failed!!!\n");
  exit(1);
}

/* ****** ****** */

extern
lamval
LAMVAL_int(int i)
{
  lamval_int p0;
  p0 = mymalloc(sizeof(lamval_int_));
  p0->tag = TAGint; p0->data = i; return (lamval)p0;
}

/* ****** ****** */

extern
lamval
LAMOPR_add(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval_int)x)->data + ((lamval_int)y)->data);
}

extern
lamval
LAMOPR_sub(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);ppp
  */
  return
  LAMVAL_int(((lamval_int)x)->data - ((lamval_int)y)->data);
}

/* ****** ****** */

extern
lamval
LAMOPR_mul(lamval x, lamval y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval_int)x)->data * ((lamval_int)y)->data);
}

/* ****** ****** */

extern
lamval
LAMVAL_print(lamval x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGcfn:
      printf("<lamval_cfn>"); break;
    case TAGint:
      printf("%i", ((lamval_int)x)->data); break;
    case TAGstr:
      printf("%s", ((lamval_str)x)->data); break;
    default: printf("Unrecognized tag = %i", tag);
  }
}

/* ****** ****** */

lamval
fact(lamval n)
{

  lamval r0, r1, r2, r3;

  r1 = n;

  /*
  printf("fact(");
  LAMVAL_print(n);
  printf(") = ...\n");
  */
  
  if
  (((lamval_int)r1)->data == 0)
  {
    r0 = (lamval)(LAMVAL_int(1));
  } else
  {
    r2 =
    LAMOPR_sub(r1, LAMVAL_int(1));
    r0 = LAMOPR_mul(r1, fact(r2));
  }
  return r0;
}

int main() {
  LAMVAL_print(fact(LAMVAL_int(10))); printf("\n"); return 0;
}
