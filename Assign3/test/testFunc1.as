	push	sp
	push	6
	add
	pop	sp
	push	10
	pop	fp[0]
	push	10
	neg
	pop	fp[1]
	push	10
	neg
	pop	fp[2]
	push	20
	pop	fp[5]
	push	fp[5]
	call	L000, 1
	puti
	end
