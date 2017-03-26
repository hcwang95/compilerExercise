	push	1
	pop	i
L000:
	push	i
	push	8
	compLE
	jz	L001
	push	0
	pop	k
	push	1
	pop	j
L003:
	push	j
	push	i
	compLE
	jz	L004
	push	k
	push	10
	mul
	push	1
	add
	pop	k
	push	j
	push	2
	div
	push	2
	mul
	push	j
	sub
	push	0
	compEQ
	jz	L006
	jmp	L005
L006:
	push	k
	print
	jmp	L005
L005:
	push	j
	push	1
	add
	pop	j
	jmp	L003
L004:
	jmp	L002
L002:
	push	i
	push	1
	add
	pop	i
	jmp	L000
L001:
	push	i
	push	2
	div
	pop	i
L007:
	push	1
	jz	L008
	push	88
	print
	push	i
	push	1
	sub
	pop	i
	push	i
	push	1
	compEQ
	jz	L009
	jmp	L008
L009:
	jmp	L007
L008:
