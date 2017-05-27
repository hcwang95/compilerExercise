	push	sp
	push	1205
	add
	pop	sp
	push	10
	push	1
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	22
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	pop	ac
	pop	sb[ac]
	push	10000000
	push	2
	push	3
	push	4
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	10
	mul
	push	ac
	add
	pop	ac
	push	100
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	201
	add
	pop	ac
	pop	sb[ac]
	push	1111
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	1201
	add
	pop	ac
	pop	sb[ac]
	push	1
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	22
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	pop	ac
	push	sb[ac]
	puti
	push	2
	push	3
	push	4
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	10
	mul
	push	ac
	add
	pop	ac
	push	100
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	201
	add
	pop	ac
	push	sb[ac]
	puti
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	1201
	add
	pop	ac
	push	sb[ac]
	puti
	call	L000, 0
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	1201
	add
	pop	ac
	push	sb[ac]
	puti
	end
L000:
	push	sp
	push	3
	add
	pop	sp
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'c'
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	"tset"
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	push	sb[ac]
	puti
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	push	sb[ac]
	putc
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	push	sb[ac]
	puts
	push	fp
	push	0
	add
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	1201
	add
	pop	ac
	push	sb[ac]
	puti
	puti
	ret
