	read
	push	0
	push	0
	add
	popi	a
	read
	push	1
	push	0
	add
	popi	a
	read
	push	2
	push	0
	add
	popi	a
	read
	push	3
	push	0
	add
	popi	a
	push	0
	push	0
	add
	pushi	a
	print
	push	4
	pop	i
L000:
	push	i
	push	0
	compGT
	jz	L001
	push	i
	push	0
	add
	pushi	a
	print
	jmp	L002
L002:
	push	i
	push	1
	sub
	pop	i
	jmp	L000
L001:
