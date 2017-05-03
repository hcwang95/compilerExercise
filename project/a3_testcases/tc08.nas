	push	sp
	push	1
	add
	pop	sp
	push	999
	pop	fp[0]
	push	fp[0]
	call	L000, 1
	end
L000:
	push	fp[-4]
	puti
	push	0
	ret
