	push	sp
	push	15
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
	push	0
	pop	fp[0]
	push	"Are you ready to play it? (y/n)"
	puts
	getc
	pop	fp[1]
	gets
	pop	fp[2]
	push	fp[1]
	push	'n'
	compEQ
	push	fp[1]
	push	'N'
	compEQ
	or
	j0	L003
	jmp	L002
L003:
	push	"Are you ready to play it? (y/n)"
	puts
	call	L004, 0
	push	fp[0]
	push	2
	mod
	push	0
	compEQ
	j0	L005
	push	1
	pop	fp[3]
	push	fp[3]
	call	L006, 1
	jmp	L007
L005:
	call	L008, 0
L007:
	push	fp[0]
	push	1
	add
	pop	fp[0]
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
L009:
	push	fp[0]
	push	9
	compLT
	j0	L010
	call	L012, 0
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
L013:
	push	1
	j0	L014
	geti
	pop	fp[2]
	push	fp[2]
	call	L015, 1
	pop	fp[1]
	push	fp[1]
	j0	L016
	jmp	L014
	jmp	L017
L016:
	push	"Your choice is invalid, please choose again!"
	puts
L017:
	jmp	L013
L014:
	push	fp[0]
	push	2
	mod
	push	1
	add
	push	fp[2]
	call	L018, 2
	call	L019, 0
	pop	fp[3]
	push	fp[3]
	push	'X'
	compEQ
	j0	L020
	push	1
	pop	sb[4]
	jmp	L010
	jmp	L021
L020:
	push	fp[3]
	push	'O'
	compEQ
	j0	L022
	push	2
	pop	sb[4]
	jmp	L010
L022:
L021:
	jmp	L011
L011:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L009
L010:
	push	sb[4]
	push	0
	compEQ
	j0	L023
	push	"Tie!"
	puts
	jmp	L024
L023:
	push	sb[4]
	push	1
	compEQ
	j0	L025
	push	"Player 1 wins!"
	puts
	jmp	L026
L025:
	push	"Player 2 wins!"
	puts
L026:
L024:
	push	0
	ret
L000:
	push	0
	pop	sb[5]
	push	0
	pop	sb[4]
	call	L027, 0
	push	0
	ret
L027:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
	push	fp[0]
L028:
	push	fp[0]
	push	3
	compLT
	j0	L029
	push	0
	pop	fp[1]
	push	fp[1]
L031:
	push	fp[1]
	push	3
	compLT
	j0	L032
	push	fp[0]
	push	3
	mul
	push	fp[1]
	add
	push	1
	add
	call	L034, 1
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
	push	6
	add
	pop	ac
	pop	sb[ac]
	jmp	L033
L033:
	push	fp[1]
	push	1
	add
	pop	fp[1]
	jmp	L031
L032:
	jmp	L030
L030:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L028
L029:
	push	0
	ret
L008:
	call	L027, 0
	push	0
	ret
L034:
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
L012:
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
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
	push	6
	add
	pop	ac
	push	sb[ac]
	call	L035, 1
	push	'\n'
	putc
	push	0
	ret
L035:
	push	' '
	putc_
	push	fp[-4]
	putc_
	push	' '
	putc_
	push	0
	ret
L018:
	push	sp
	push	3
	add
	pop	sp
	push	'X'
	pop	fp[0]
	push	fp[-5]
	push	2
	compEQ
	j0	L036
	push	'O'
	pop	fp[0]
L036:
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
	push	6
	add
	pop	ac
	pop	sb[ac]
	push	0
	ret
L015:
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
	j0	L037
	push	0
	ret
L037:
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
	push	6
	add
	pop	ac
	push	sb[ac]
	push	fp[-4]
	call	L034, 1
	compEQ
	j0	L038
	push	1
	ret
	jmp	L039
L038:
	push	0
	ret
L039:
L019:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
L040:
	push	fp[0]
	push	3
	compLT
	j0	L041
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L043
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L044
	push	fp[1]
	ret
L044:
L043:
	jmp	L042
L042:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L040
L041:
	push	0
	pop	fp[0]
L045:
	push	fp[0]
	push	3
	compLT
	j0	L046
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L048
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L049
	push	fp[1]
	ret
L049:
L048:
	jmp	L047
L047:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L045
L046:
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L050
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L051
	push	fp[1]
	ret
L051:
L050:
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L052
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
	push	6
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
	push	6
	add
	pop	ac
	push	sb[ac]
	compEQ
	j0	L053
	push	fp[1]
	ret
L053:
L052:
	push	0
	ret
L006:
	push	fp[-4]
	call	L054, 1
	push	0
	ret
L054:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
	push	fp[0]
L055:
	push	fp[0]
	push	3
	compLT
	j0	L056
	push	0
	pop	fp[1]
	push	fp[1]
L058:
	push	fp[1]
	push	3
	compLT
	j0	L059
	push	10
	push	fp[0]
	push	3
	mul
	sub
	push	fp[1]
	sub
	push	1
	sub
	call	L034, 1
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
	push	6
	add
	pop	ac
	pop	sb[ac]
	jmp	L060
L060:
	push	fp[1]
	push	1
	add
	pop	fp[1]
	jmp	L058
L059:
	jmp	L057
L057:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L055
L056:
	push	0
	ret
