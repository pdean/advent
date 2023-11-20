with open("input.txt") as f: l = list(map(int, f))                      # Task 1
print(sum(y > x for x, y in zip(l, l[1:])))     
l = [sum(tri) for tri in zip(l, l[1:], l[2:])]                      # Task 2   
print(sum(y > x for x, y in zip(l, l[1:])))