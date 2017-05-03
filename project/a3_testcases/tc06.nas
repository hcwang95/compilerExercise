	push	sp
	push	3
	add
	pop	sp
	push	1
	pop	fp[0]
	push	1
	pop	fp[1]
L000:
	push	fp[1]
	push	100
	compLT
	j0	L001
	push	fp[1]
	pop	fp[2]
L003:
	push	fp[2]
	push	0
	compGT
	j0	L004
	push	fp[2]
	push	2
	div
	pop	fp[2]
	push	fp[2]
	push	1
	compEQ
	j0	L005
	jmp	L004
L005:
	jmp	L003
L004:
	push	fp[1]
	push	10
	compLT
	j0	L006
	jmp	L002
L006:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L002
L002:
	push	fp[1]
	push	fp[0]
	add
	pop	fp[1]
	jmp	L000
L001:
	push	fp[1]
	puti_
	push	", "
	puts_
	push	fp[2]
	puti_
	push	", "
	puts_
	push	fp[0]
	puti
	end
