	push	sp
	push	11
	add
	pop	sp
	push	10
	pop	fp[0]
	push	20
	pop	fp[1]
	push	fp[0]
	puti
	push	fp[1]
	puti
	push	10000
	pop	fp[2]
	push	20
	pop	fp[3]
	push	30
	pop	fp[4]
	push	fp[2]
	puti_
	push	fp[3]
	puti
	push	fp[4]
	puti
	push	'c'
	pop	fp[5]
	push	'\t'
	pop	fp[6]
	push	'\n'
	pop	fp[7]
	push	fp[5]
	putc_
	push	fp[6]
	putc_
	push	fp[5]
	call	L000, 1
	putc
	push	fp[7]
	putc
	push	"ansdfasdf"
	pop	fp[8]
	push	fp[8]
	pop	fp[9]
	push	"201249"
	pop	fp[10]
	push	fp[8]
	puts_
	push	fp[9]
	puts
	push	fp[10]
	puts
	push	"repeat it again"
	puts
	push	10
	pop	fp[0]
	push	20
	pop	fp[1]
	push	fp[0]
	puti
	push	fp[1]
	puti
	push	10000
	pop	fp[2]
	push	20
	pop	fp[3]
	push	30
	pop	fp[4]
	push	fp[2]
	puti_
	push	fp[3]
	puti
	push	fp[4]
	puti
	push	'c'
	pop	fp[5]
	push	'\t'
	pop	fp[6]
	push	'\n'
	pop	fp[7]
	push	fp[5]
	putc_
	push	fp[6]
	putc_
	push	fp[5]
	call	L000, 1
	putc
	push	fp[7]
	putc
	push	"ansdfasdf"
	pop	fp[8]
	push	fp[8]
	pop	fp[9]
	push	"201249"
	pop	fp[10]
	push	fp[8]
	puts_
	push	fp[9]
	puts
	push	fp[10]
	puts
	end
L000:
	push	fp[-4]
	push	'z'
	compLE
	push	fp[-4]
	push	'a'
	compGE
	and
	j0	L001
	push	fp[-4]
	putc
	push	"we want it to become capital letter"
	puts
L001:
	push	fp[-4]
	push	32
	sub
	ret
L000:
	push	fp[-4]
	push	'z'
	compLE
	push	fp[-4]
	push	'a'
	compGE
	and
	j0	L002
	push	fp[-4]
	putc
	push	"we want it to become capital letter"
	puts
L002:
	push	fp[-4]
	push	32
	sub
	ret
