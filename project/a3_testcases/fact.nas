	push	sp
	push	1
	add
	pop	sp
	push	"Please enter a +ve int <= 12: "
	puts_
	geti
	pop	fp[0]
	push	fp[0]
	push	12
	compLE
	j0	L000
	push	fp[0]
	call	L001, 1
	puti
	jmp	L002
L000:
	push	fp[0]
	puti_
	push	" > 12!!"
	puts
L002:
	end
L001:
	push	fp[-4]
	push	1
	compLT
	j0	L003
	push	1
	ret
L003:
	push	fp[-4]
	push	fp[-4]
	push	1
	sub
	call	L001, 1
	mul
	ret
