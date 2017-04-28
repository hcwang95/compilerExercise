	push	sp
	push	1
	add
	pop	sp
	push	"Please enter a +ve int < 13: "
	puts
	geti
	pop	fp[0]
	push	fp[0]
	call	L000, 1
	puti
	end
L000:
	push	fp[-4]
	push	1
	compEQ
	j0	L001
	push	1
	ret
	jmp	L002
L001:
	push	fp[-4]
	push	1
	sub
	call	L000, 1
	push	fp[-4]
	mul
	ret
L002:
