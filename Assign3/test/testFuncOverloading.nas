	push	sp
	push	8
	add
	pop	sp
	push	20
	pop	fp[6]
	push	fp[6]
	push	10
	call	L000, 2
	puti
	push	20
	call	L001, 1
	end
L000:
	push	sp
	push	2
	add
	pop	sp
	push	20
	pop	fp[0]
	push	30
	pop	fp[1]
	push	fp[0]
	puti
	push	fp[1]
	puti
	push	fp[-5]
	puti
	push	fp[-5]
	push	10
	compGT
	j0	L002
	push	fp[-5]
	puti
	push	"i is larger than 10"
	puts
	jmp	L003
L002:
	push	fp[-5]
	puti
	push	"i is smaller than 10"
	puts
L003:
	push	fp[-5]
	push	10
	add
	call	L004, 1
	ret
L001:
	push	"this is function overloading"
	puts
	push	fp[-4]
	ret
L001:
	push	"this is function redefinition"
	puts
	push	fp[-4]
	ret
