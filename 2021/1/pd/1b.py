#!/usr/bin/env python

file = 'input.txt'

sum = 0
list = []

with open(file,'r') as f:
    for l in f:
        list.append(int(l.split()[0]))
        
for t in zip(list[0:-1],list[1:]):
    a,b = t
    if b>a:
        sum+=1
print(sum)    
