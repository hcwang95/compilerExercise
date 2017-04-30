	push	sp
	push	1
	add
	pop	sp
	push	3
	call	L000, 1
	push	fp[0]
	puti
	end
L000:
	push	10
	pop	sb[0]
	push	0
	ret
