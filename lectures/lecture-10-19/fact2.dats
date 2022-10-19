
fun
fact(x: int): int = loop(0, 1, x)
and
loop(i: int, res: int, x: int): int =
if i < x then loop(i+1, res *(i+1), x) else res
