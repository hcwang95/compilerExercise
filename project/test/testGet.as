	push	sp
	push	6
	add
	pop	sp
	push	10
	pop	fp[0]
	push	0
	pop	fp[1]
	push	20
	pop	fp[2]
	push	20
	pop	fp[3]
	push	0
	pop	fp[4]
L000:
	push	fp[4]
	push	10
	compLT
	j0	L001
	push	"give a number:"
	puts_
	geti
	pop	fp[5]
	push	"You input a number: "
	puts_
	push	fp[5]
	puti
	jmp	L002
L002:
	push	fp[4]
	push	1
	add
	pop	fp[4]
	jmp	L000
L001:
