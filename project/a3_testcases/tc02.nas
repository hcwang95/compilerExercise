	push	sp
	push	3
	add
	pop	sp
	getc
	pop	fp[0]
	push	fp[0]
	pop	fp[1]
	push	'X'
	pop	fp[2]
	push	fp[1]
	putc_
	push	fp[2]
	putc
	end
