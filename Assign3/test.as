	push	10
	push	10
	push	100
	push	15
	push	fp[0]
	push	1
	compGT
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
	push	10
