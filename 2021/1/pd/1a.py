#!/usr/bin/env python

file = 'input.txt'

sum = 0

with open(file,'r') as f:
    a = int(next(f).split()[0])
    for l in f:
        b = int(l.split()[0])
        if b>a:
            sum +=1
        a = b
        
print(sum)    
