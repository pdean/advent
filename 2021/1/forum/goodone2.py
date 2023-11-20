levels = list(map(int, open("input.txt")))
count = lambda step: sum(lhs < rhs for (lhs, rhs) in zip(levels[:-step], levels[step:]))
print(count(1), count(3))