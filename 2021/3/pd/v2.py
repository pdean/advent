input = [list(map(int,list(line.strip()))) for line in open('input.txt')]

data = input
m = len(data[0])
sums = [0]*m
a = len(data) // 2
for d in data:
    for i,x in enumerate(d):
        sums[i] += x
gam = [int(x>a) for x in sums]
eps = [int(x<a) for x in sums]
print(int(''.join(map(str,gam)),2)*int(''.join(map(str,eps)),2))        
        
data = input
res = data
for i in range(m):
    n = len(res)
    if n == 1:break
    ones = 0
    for d in res:
        ones += d[i]
    bit = int(ones>=(n-ones))
    res = list(x for x in res if x[i] == bit)
oxy=res[0]
res = data
for i in range(m):
    n = len(res)
    if n == 1:break
    ones = 0
    for d in res:
        ones += d[i]
    bit = int(ones<(n-ones))
    res = list(x for x in res if x[i] == bit)
co2 = res[0]
print(int(''.join(map(str,oxy)),2)*int(''.join(map(str,co2)),2))        
    
    
    
