	push	sp
	push	3
	add
	pop	sp
	push	10
	pop	fp[0]
	push	15
	pop	fp[1]
	push	40
	pop	fp[2]
	push	fp[0]
	push	fp[2]
	push	fp[2]
	push	fp[1]
	call	L000, 4
	pop	fp[2]
	push	fp[2]
	puti
	end
L000:
	push	fp[-7]
	push	fp[-6]
	add
	push	fp[-5]
	push	fp[-4]
	add
	mul
	ret
