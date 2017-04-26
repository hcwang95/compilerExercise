	push	sp
	push	2
	add
	pop	sp
	push	999
	pop	fp[1]
	push	fp[1]
	call	L000, 1
	end
L000:
	push	fp[-4]
	puti
	push	0
	ret
