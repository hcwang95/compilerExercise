	push	sp
	push	0
	add
	pop	sp
	call	L000, 0
	call	L001, 0
	call	L002, 0
	end
L000:
	push	1
	puti
	push	0
	ret
L001:
	push	5
	puti
	push	0
	ret
L002:
	push	12
	puti
	push	0
	ret
