.section .text     
.align 2 
.globl bubblesort

## /*
## void bubblesort(int *p, int n) {
##     int swapped = 1;
##     while (swapped != 0) {
##         swapped = 0;
##         for (int i = 0; i < n - 1; i++) {
##             if (p[i] > p[i + 1]) {
##                 int tmp = p[i];
##                 p[i] = p[i + 1];
##                 p[i + 1] = tmp;
##                 swapped = 1;
##             }
##         }
##         n = n - 1;
##     }
## }
## */

bubblesort:
  # a0 is p
  # a1 is n
##############################
# YOUR CODE HERE!
##############################
  li a2, 1 # a2 is swapped
bubblesort_while:
  beq a2, zero, bubblesort_done
  li a2, 0 # swapped = 0
  li a3, 0 # a3 is i: i = 0
bubblesort_while_for:
  addi t0, a1, -1
  bge a3, t0, bubblesort_while_for_done
bubblesort_while_for_if:
  mv t0, a3
  slli t1, t0, 2
  add t1, a0, t1
  lw t2, 0(t1)
  addi t0, a3, 1
  slli t3, t0, 2
  add t3, a0, t3
  lw t4, 0(t3)
  ble t2, t4, bubblesort_while_for_post
  sw t4, 0(t1)
  sw t2, 0(t3)
  li a2, 1
##############################
  addi sp, sp, -36
  sw a0, 0(sp)
  sw a1, 4(sp)
  sw a2, 8(sp)
  sw a3, 12(sp)
  sw a4, 16(sp)
  sw a5, 20(sp)
  sw a6, 24(sp)
  sw a7, 28(sp)
  sw ra, 32(sp)
  jal arrayViz
  lw a0, 0(sp)
  lw a1, 4(sp)
  lw a2, 8(sp)
  lw a3, 12(sp)
  lw a4, 16(sp)
  lw a5, 20(sp)
  lw a6, 24(sp)
  lw a7, 28(sp)
  lw ra, 32(sp)
  addi sp, sp, 36
##############################
bubblesort_while_for_post:
  addi a3, a3, 1
  beq zero, zero, bubblesort_while_for
bubblesort_while_for_done:
  addi a1, a1, -1
  beq zero, zero, bubblesort_while
bubblesort_while_done:
bubblesort_done:
  ret
