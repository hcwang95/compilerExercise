	push	sp
	push	3
	add
	pop	sp
	push	100
	pop	fp[0]
	push	100
	pop	fp[1]
	push	20
	pop	fp[2]
	push	fp[0]
	push	fp[1]
	compGE
	j0	L000
	push	"a>b"
	puts
	push	fp[0]
	push	fp[1]
	compEQ
	j0	L001
	push	"a==b"
	puts
L001:
	jmp	L002
L000:
	push	"a<b"
	puts
L002:
	push	fp[2]
	push	fp[0]
	compLT
	j0	L003
	push	"c<a"
	puts
	jmp	L004
L003:
	push	"c>=a"
	puts
L004:
	end
