#include <stdio.h>

extern
int fact(int n);

#define N 1000000

/* ****** ****** */

int
main() {
  printf("fact(%i) = %i\n", N, fact(N));
  return 0;
}

/* ****** ****** */

/*
int
fact(int n) {
  return (n > 0) ? n*fact(n-1) : 1;
  // if (n > 0) return n*fact(n-1); else return 1;
}
*/

/*
int
fact(int n) {
  int res;
  res = 1;
  while(n > 0) {
    res = n * res; n = n - 1;
  }
  return res;
}
*/

/* ****** ****** */

int
fact2(int n, int r) {
  if (n > 0) return fact2(n-1, n*r); else return r;
}

int fact(int n) { return fact2(n, 1); }

/* ****** ****** */

/* end of [fact.c] */
