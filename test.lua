require "ltspack"

bpack=string.pack
bunpack=string.unpack

function hex(s)
 s=string.gsub(s,"(.)",function (x) return string.format("%02X",string.byte(x)) end)
 return s
end

print"Lua header"

a=bpack("Ab8","\027Lua",5*16+1,0,1,4,4,4,8,0)
print(hex(a),string.len(a))
print(bunpack(a,"bA3b8"))

b=string.dump(hex)
b=string.sub(b,1,string.len(a))
print(a==b,string.len(b))
print(bunpack(b,"bA3b8"))

function test(w,i,f)
	a=bpack(f,i,i,i)
	print""
	print(w)
	print(hex(a))
	print(bunpack(a,f))
	a=hex(a)
	n=#a/3
	print((string.sub(a,1,n)))
	print((string.sub(a,n+1,2*n)))
	print((string.sub(a,2*n+1,3*n)))
end

test("integer",314159265,"<I>I=I")
test("float",3.14159265,"<d>d=d")
