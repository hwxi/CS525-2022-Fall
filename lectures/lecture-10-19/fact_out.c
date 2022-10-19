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
lamval1
LAMVAL_print(lamval1 x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGcfp:
      printf("<lamval1_cfp>"); break;
    case TAGint:
      printf("%i", ((lamval1_int)x)->data); break;
    case TAGstr:
      printf("%s", ((lamval1_str)x)->data); break;
    default: printf("Unrecognized tag = %i", tag);
  }
}

/* ****** ****** */

/*
fun
fact(x) = if x > 0 then x * fact(x-1) else 1
*/

/* ****** ****** */

lamval1
fact(lamval1 x)
{

  lamval1 ret0;
  lamval1 tmp1, tmp2, tmp3;

  tmp1 = LAMOPR_igt(x, LAMVAL_int(0));

  if (((lamval1_int)tmp1)->data) {
    tmp2 = LAMOPR_sub(x, LAMVAL_int(1));
    tmp3 = fact(tmp2);
    ret0 = LAMOPR_mul(x, tmp3);
  } else {
    ret0 = LAMVAL_int(1);
  }

  return ret0;
}

int main() {
  LAMVAL_print(fact(LAMVAL_int(10))); printf("\n"); return 0;
}
