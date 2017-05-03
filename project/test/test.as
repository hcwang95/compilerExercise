	push	sp
	push	6
	add
	pop	sp
	push	10
	pop	fp[0]
	push	10
	pop	fp[1]
	push	100
	pop	fp[2]
	push	15
	pop	fp[3]
	push	fp[0]
	push	1
	compLT
	j0	L000
	push	'\n'
	putc_
	jmp	L001
L000:
	push	"asdfajslk asdnfalkj aa10923823jtna\"\n\n\nx"
	puts
	push	20
	pop	fp[0]
L001:
	push	fp[0]
	push	10
	add
	puti
	push	11
	pop	fp[4]
	push	10
	pop	fp[5]
