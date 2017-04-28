	push	sp
	push	3
	add
	pop	sp
	gets
	pop	fp[0]
	push	fp[0]
	pop	fp[1]
	push	"test!"
	pop	fp[2]
	push	fp[1]
	puts_
	push	fp[2]
	puts
	end
