	push	sp
	push	8
	add
	pop	sp
	push	10
	pop	fp[0]
	push	10
	neg
	pop	fp[1]
	push	10
	neg
	pop	fp[2]
	push	20
	pop	fp[3]
	push	20
	pop	fp[7]
	push	fp[7]
	push	10
	call	L000, 2
	puti
	end
L000:
	push	sp
	push	2
	add
	pop	sp
	push	20
	pop	fp[0]
	push	30
	pop	fp[1]
	push	fp[0]
	puti
	push	fp[1]
	puti
	push	fp[-5]
	puti
	push	fp[-5]
	push	10
	compGT
	j0	L001
	push	fp[-5]
	puti
	push	"i is larger than 10"
	puts
	jmp	L002
L001:
	push	fp[-5]
	puti
	push	"i is smaller than 10"
	puts
L002:
	push	fp[-5]
	push	10
	add
	call	L003, 1
	ret
L003:
	push	sp
	push	2
	add
	pop	sp
	push	"enter function cde"
	puts
	push	20
	pop	fp[0]
	push	15
	pop	fp[1]
	push	fp[-4]
	push	10
	add
	ret
