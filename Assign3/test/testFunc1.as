	push	sp
	push	6
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
	pop	fp[5]
	push	fp[5]
	call	L000, 1
	puti
	end
L000:
0
	push	20
	pop	fp[0]
	push	fp[-4]
	puti
	push	fp[-4]
	puti
	push	fp[-4]
	push	10
	compGT
	j0	L001
	push	fp[-4]
	puti
	push	"i is larger than 10"
	puts
	jmp	L002
L001:
	push	fp[-4]
	puti
	push	"i is smaller than 10"
	puts
L002:
	push	fp[-4]
	push	10
	add
	call	L003, 1
	ret
L003:
1
	push	sp
	push	1
	add
	pop	sp
	push	"enter function cde"
	puts
	push	fp[-4]
	push	10
	add
	ret
