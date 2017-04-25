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
	push	10
	call	L000, 1
	end
L000:
	push	sp
	push	0
	add
	pop	sp
	push	fp[-4]
	puti
	ret
