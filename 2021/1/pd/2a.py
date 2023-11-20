#!/usr/bin/env python

file = 'input.txt'

sum = 0
l = []

with open(file,'r') as f:
    for r in f:
        l.append(int(r.split()[0]))

ll = []
for t in zip(l[0:-2],l[1:-1],l[2:]):
    a,b,c = t
    s = a+b+c
    ll.append(s)

for t in zip(ll[0:-1],ll[1:]):
    a,b = t
    if b>a:
        sum+=1
print(sum)    


