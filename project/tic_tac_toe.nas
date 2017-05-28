	push	sp
	push	13
	add
	pop	sp
	push	"Starting...\n"
	puts_
	call	L000, 0
	push	"Welcome to Tic-Tac-Toe!"
	puts
L001:
	push	1
	j0	L002
	push	"Are you ready to play it? (y/n)"
	puts
	getc
	pop	fp[0]
	gets
	pop	fp[1]
	push	fp[0]
	push	'n'
	compEQ
	push	fp[0]
	push	'N'
	compEQ
	or
	j0	L003
	jmp	L002
L003:
	call	L004, 0
	call	L005, 0
	jmp	L001
L002:
	push	"Bye!"
	puts
	end
L004:
	push	sp
	push	4
	add
	pop	sp
	push	"Game start!"
	puts
	push	0
	pop	fp[0]
L006:
	push	fp[0]
	push	9
	compLT
	j0	L007
	call	L009, 0
	push	"Player "
	puts_
	push	fp[0]
	push	2
	mod
	push	1
	add
	puti_
	push	": Give your choice [1-9]"
	puts
	push	0
	pop	fp[1]
	push	0
	pop	fp[2]
L010:
	push	1
	j0	L011
	geti
	pop	fp[2]
	push	fp[2]
	call	L012, 1
	pop	fp[1]
	push	fp[1]
	j0	L013
	jmp	L011
	jmp	L014
L013:
	push	"Your choice is invalid, please choose again!"
	puts
L014:
	jmp	L010
L011:
	push	fp[0]
	push	2
	mod
	push	1
	add
	push	fp[2]
	call	L015, 2
	call	L016, 0
	pop	fp[3]
	push	fp[3]
	push	'X'
	compEQ
	j0	L017
	push	1
	pop	sb[2]
	jmp	L007
	jmp	L018
L017:
	push	fp[3]
	push	'O'
	compEQ
	j0	L019
	push	2
	pop	sb[2]
	jmp	L007
L019:
L018:
	jmp	L008
L008:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L006
L007:
	push	sb[2]
	push	0
	compEQ
	j0	L020
	push	"Tie!"
	puts
	jmp	L021
L020:
	push	sb[2]
	push	1
	compEQ
	j0	L022
	push	"Player 1 wins!"
	puts
	jmp	L023
L022:
	push	"Player 2 wins!"
	puts
L023:
L021:
	push	0
	ret
L000:
	push	0
	pop	sb[3]
	push	0
	pop	sb[2]
	call	L024, 0
	push	0
	ret
L024:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
	push	fp[0]
L025:
	push	fp[0]
	push	3
	compLT
	j0	L026
	push	0
	pop	fp[1]
	push	fp[1]
L028:
	push	fp[1]
	push	3
	compLT
	j0	L029
	push	fp[0]
	push	3
	mul
	push	fp[1]
	add
	push	1
	add
	call	L031, 1
	push	fp[0]
	push	fp[1]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	pop	sb[ac]
	jmp	L030
L030:
	push	fp[1]
	push	1
	add
	pop	fp[1]
	jmp	L028
L029:
	jmp	L027
L027:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L025
L026:
	push	0
	ret
L005:
	call	L024, 0
	push	0
	ret
L031:
	push	sp
	push	10
	add
	pop	sp
	push	'0'
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'1'
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'2'
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'3'
	push	3
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'4'
	push	4
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'5'
	push	5
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'6'
	push	6
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'7'
	push	7
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'8'
	push	8
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	'9'
	push	9
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	pop	sb[ac]
	push	fp[-4]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	0
	add
	push	fp
	add
	pop	ac
	push	sb[ac]
	ret
L009:
	push	'\n'
	putc
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	0
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	"\n---+---+---"
	puts
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	1
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	"\n---+---+---"
	puts
	push	2
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	2
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'|'
	putc_
	push	2
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	call	L032, 1
	push	'\n'
	putc
	push	0
	ret
L032:
	push	' '
	putc_
	push	fp[-4]
	putc_
	push	' '
	putc_
	push	0
	ret
L015:
	push	sp
	push	3
	add
	pop	sp
	push	'X'
	pop	fp[0]
	push	fp[-5]
	push	2
	compEQ
	j0	L033
	push	'O'
	pop	fp[0]
L033:
	push	fp[-4]
	push	1
	sub
	push	3
	div
	pop	fp[1]
	push	fp[-4]
	push	1
	sub
	push	3
	mod
	pop	fp[2]
	push	fp[0]
	push	fp[1]
	push	fp[2]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	pop	sb[ac]
	push	0
	ret
L012:
	push	sp
	push	2
	add
	pop	sp
	push	fp[-4]
	push	1
	compLT
	push	fp[-4]
	push	9
	compGT
	or
	j0	L034
	push	0
	ret
L034:
	push	fp[-4]
	push	1
	sub
	push	3
	div
	pop	fp[0]
	push	fp[-4]
	push	1
	sub
	push	3
	mod
	pop	fp[1]
	push	fp[0]
	push	fp[1]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	push	fp[-4]
	call	L031, 1
	compEQ
	j0	L035
	push	1
	ret
	jmp	L036
L035:
	push	0
	ret
L036:
L016:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
L037:
	push	fp[0]
	push	3
	compLT
	j0	L038
	push	fp[0]
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	push	fp[0]
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L040
	push	fp[0]
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	pop	fp[1]
	push	fp[1]
	push	fp[0]
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L041
	push	fp[1]
	ret
L041:
L040:
	jmp	L039
L039:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L037
L038:
	push	0
	pop	fp[0]
L042:
	push	fp[0]
	push	3
	compLT
	j0	L043
	push	0
	push	fp[0]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	push	1
	push	fp[0]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L045
	push	0
	push	fp[0]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	pop	fp[1]
	push	fp[1]
	push	2
	push	fp[0]
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L046
	push	fp[1]
	ret
L046:
L045:
	jmp	L044
L044:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L042
L043:
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L047
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	pop	fp[1]
	push	fp[1]
	push	2
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L048
	push	fp[1]
	ret
L048:
L047:
	push	0
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L049
	push	0
	push	2
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	pop	fp[1]
	push	fp[1]
	push	2
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	3
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	4
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L050
	push	fp[1]
	ret
L050:
L049:
	push	0
	ret
