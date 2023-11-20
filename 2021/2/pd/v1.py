# vim: sts=4 sw=4 tw=80 et:
test = [line.strip().split() for line in open('test.txt')]
data = [line.strip().split() for line in open('input.txt')]
print(sum(int(b) for a,b in data if a == 'forward') 
         * (sum(int(b) for a,b in data if a == 'down') -
            sum(int(b) for a,b in data if a == 'up')))
			
a = f = d = 0
for k,v in data:
    v = int(v)
    if k == 'forward':
        f+=v
        d+=a*v
    if k == 'up':
        a-=v
    if k == 'down':
        a+=v

print(f*d)		
		
	    
		
    
