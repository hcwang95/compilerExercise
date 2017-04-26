	push	sp
	push	3
	add
	pop	sp
	push	10
	neg
	pop	fp[0]
	push	10
	pop	fp[1]
	push	10
	neg
	pop	fp[2]
	push	5
	call	L000, 1
	puti
	end
L000:
	push	fp[-4]
	push	10
	compEQ
	j0	L001
	push	10
	ret
	jmp	L002
L001:
	push	fp[-4]
	push	1
	add
	call	L000, 1
	push	fp[-4]
	add
	ret
L002:
