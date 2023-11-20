# vim: sts=4 sw=4 tw=80 et:
test = [list(map(int,list(line.strip()))) for line in open('test.txt')]
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
        
data=test
