	push	sp
	push	0
	add
	pop	sp
	call	L000, 0
	call	L000, 0
	call	L000, 0
	end
L000:
	push	"OK"
	puts
	push	0
	ret
