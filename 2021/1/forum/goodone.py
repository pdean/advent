d = list(map(int, open("input.txt")))
print(sum(a < b for a, b in zip(d, d[1:])))
print(sum(a < b for a, b in zip(d, d[3:])))