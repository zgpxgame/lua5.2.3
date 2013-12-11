for i=1,10 do foo=i end
for i=1,10,2 do break end
for i in foo do bar=0 end
for i,j in foo,bar do baz=0 end