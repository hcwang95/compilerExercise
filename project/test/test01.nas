	push	sp
	push	1
	add
	pop	sp
	push	20
	pop	fp[0]
	push	fp[0]
	push	20
	call	L000, 2
	pop	fp[0]
	push	fp[0]
	puti
	push	"hello world!!"
	puts
	push	fp[0]
	call	L001, 1
	j0	L002
	push	'\n'
	putc
	jmp	L003
L002:
	push	"heiheihei"
	puts
L003:
	end
L000:
	push	"testing with two arguments"
	puts
	push	fp[-5]
	push	fp[-4]
	add
	puti
	geti
	pop	fp[-5]
	push	fp[-5]
	push	fp[-4]
	compLT
	puti
	push	fp[-5]
	push	fp[-4]
	push	10
	call	L004, 3
	ret
L004:
	push	"here is testing with three arguments"
	puts
	push	fp[-6]
	push	fp[-5]
	push	fp[-4]
	mul
	add
	ret
L001:
	push	fp[-4]
	push	20
	compLT
	ret
