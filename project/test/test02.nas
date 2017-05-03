	push	sp
	push	1
	add
	pop	sp
	push	's'
	pop	fp[0]
	push	1
	push	0
	compGT
	j0	L000
	push	10
	pop	fp[0]
L000:
	push	fp[0]
	puti
	push	20
	push	10
	add
	pop	fp[0]
	push	fp[0]
	call	L001, 1
	end
L001:
	push	sp
	push	2
	add
	pop	sp
	push	10
	pop	fp[0]
	push	20
	pop	fp[1]
	push	fp[-4]
L002:
	push	fp[-4]
	push	30
	compLT
	j0	L003
	push	fp[-4]
	push	fp[1]
	compLT
	j0	L005
	push	0
	ret
L005:
	push	fp[-4]
	push	fp[0]
	compLT
	j0	L006
	push	20
	ret
	jmp	L007
L006:
	push	"here we do not exit"
	puts
L007:
	push	20
	pop	fp[-4]
	push	30
	pop	fp[0]
	push	30
	pop	fp[1]
	push	fp[-4]
	push	fp[0]
	add
	push	fp[0]
	add
	push	fp[1]
	add
	ret
	jmp	L004
L004:
	push	fp[-4]
	push	1
	add
	pop	fp[-4]
	jmp	L002
L003:
	push	"important"
	puts
	push	0
	ret
