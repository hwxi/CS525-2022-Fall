.section .text      
.align 2            
.globl collatz     

collatz:
If:
  andi  a1, a0, 1
  bnez  a1, Else
Then:
  srai  a0, a0, 1
  j     End
Else:
  slli  a2, a0, 1
  add   a0, a2, a0
  addi  a0, a0, 1
End:
  ret