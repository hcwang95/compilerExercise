	push	sp
	push	15
	add
	pop	sp
	push	"Starting...\n"
	puts_
	call	L000, 0
	push	"Welcome to Tic-Tac-Toe!"
	puts
	push	0
	pop	fp[0]
L001:
	push	1
	j0	L002
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
	push	fp[0]
	push	2
	mod
	push	0
	compEQ
	j0	L004
	push	1
	pop	fp[3]
	jmp	L005
L004:
	push	0
	pop	fp[3]
L005:
	push	fp[3]
	call	L006, 1
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L001
L002:
	push	"Bye!"
	puts
	end
L006:
	push	sp
	push	8
	add
	pop	sp
	push	1
	neg
	pop	ac
	push	ac
	push	ac
	push	ac
	push	ac
	push	fp
	push	0
	add
	pop	ac
	pop	sb[ac]
	push	fp
	push	1
	add
	pop	ac
	pop	sb[ac]
	push	fp
	push	2
	add
	pop	ac
	pop	sb[ac]
	push	fp
	push	3
	add
	pop	ac
	pop	sb[ac]
	push	"Game start!"
	puts
	push	fp[-4]
	j0	L007
	push	fp[-4]
	call	L008, 1
	jmp	L009
L007:
	call	L010, 0
L009:
	push	0
	pop	fp[4]
L011:
	push	fp[4]
	push	9
	compLT
	j0	L012
	call	L014, 0
	push	"Player "
	puts_
	push	fp[4]
	push	2
	mod
	push	1
	add
	puti_
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
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
	puti
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
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
	puti
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
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
	puti
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
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
	puti
	push	": Give your choice [1-9]"
	puts
	push	0
	pop	fp[5]
	push	0
	pop	fp[6]
L015:
	push	1
	j0	L016
	geti
	pop	fp[6]
	push	fp[6]
	push	fp[-4]
	call	L017, 2
	pop	fp[5]
	push	fp[5]
	j0	L018
	jmp	L016
	jmp	L019
L018:
	push	"Your choice is invalid, please choose again!"
	puts
L019:
	jmp	L015
L016:
	push	fp[4]
	push	2
	mod
	push	1
	add
	push	fp[6]
	push	fp[-4]
	push	fp
	push	0
	add
	call	L020, 4
	call	L021, 0
	pop	fp[7]
	push	fp[7]
	push	'X'
	compEQ
	j0	L022
	push	1
	pop	sb[4]
	push	2
	call	L023, 1
	j0	L024
	push	fp
	push	0
	add
	push	fp[-4]
	call	L025, 2
	push	fp[4]
	push	2
	sub
	pop	fp[4]
	jmp	L013
	jmp	L026
L024:
	jmp	L012
L026:
	jmp	L027
L022:
	push	fp[7]
	push	'O'
	compEQ
	j0	L028
	push	2
	pop	sb[4]
	push	1
	call	L023, 1
	j0	L029
	push	fp
	push	0
	add
	push	fp[-4]
	call	L025, 2
	push	fp[4]
	push	2
	sub
	pop	fp[4]
	jmp	L013
	jmp	L030
L029:
	jmp	L012
L030:
L028:
L027:
	jmp	L013
L013:
	push	fp[4]
	push	1
	add
	pop	fp[4]
	jmp	L011
L012:
	push	sb[4]
	push	0
	compEQ
	j0	L031
	push	"Tie!"
	puts
	jmp	L032
L031:
	push	sb[4]
	push	1
	compEQ
	j0	L033
	push	"Player 1 wins!"
	puts
	jmp	L034
L033:
	push	"Player 2 wins!"
	puts
L034:
L032:
	push	0
	ret
L000:
	push	0
	pop	sb[5]
	push	0
	pop	sb[4]
	push	0
	ret
L010:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
	push	fp[0]
L035:
	push	fp[0]
	push	3
	compLT
	j0	L036
	push	0
	pop	fp[1]
	push	fp[1]
L038:
	push	fp[1]
	push	3
	compLT
	j0	L039
	push	fp[0]
	push	3
	mul
	push	fp[1]
	add
	push	1
	add
	call	L041, 1
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
	jmp	L040
L040:
	push	fp[1]
	push	1
	add
	pop	fp[1]
	jmp	L038
L039:
	jmp	L037
L037:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L035
L036:
	push	0
	ret
L041:
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
L014:
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
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
	call	L042, 1
	push	'\n'
	putc
	push	0
	ret
L042:
	push	' '
	putc_
	push	fp[-4]
	putc_
	push	' '
	putc_
	push	0
	ret
L020:
	push	sp
	push	6
	add
	pop	sp
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	'X'
	pop	fp[0]
	push	fp[-7]
	push	2
	compEQ
	j0	L043
	push	'O'
	pop	fp[0]
L043:
	push	fp[-5]
	j0	L044
	push	10
	push	fp[-6]
	sub
	pop	fp[-6]
L044:
	push	fp[-6]
	push	1
	sub
	push	3
	div
	pop	fp[1]
	push	fp[-6]
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
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	push	1
	neg
	compEQ
	j0	L045
	push	fp[1]
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	fp[2]
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	"ggggg"
	puts
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	puti
	jmp	L046
L045:
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	push	1
	neg
	compEQ
	j0	L047
	push	fp[1]
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	fp[2]
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	jmp	L048
L047:
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	push	sb[ac]
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	fp[1]
	push	1
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
	push	fp[2]
	push	1
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-4]
	add
	pop	ac
	pop	sb[ac]
L048:
L046:
	push	0
	ret
L017:
	push	sp
	push	2
	add
	pop	sp
	push	fp[-5]
	push	1
	compLT
	push	fp[-5]
	push	9
	compGT
	or
	j0	L049
	push	0
	ret
L049:
	push	fp[-4]
	push	0
	compEQ
	j0	L050
	push	fp[-5]
	push	1
	sub
	push	3
	div
	pop	fp[0]
	push	fp[-5]
	push	1
	sub
	push	3
	mod
	pop	fp[1]
	jmp	L051
L050:
	push	10
	push	fp[-5]
	sub
	push	1
	sub
	push	3
	div
	pop	fp[0]
	push	10
	push	fp[-5]
	sub
	push	1
	sub
	push	3
	mod
	pop	fp[1]
L051:
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
	push	fp[-5]
	call	L041, 1
	compEQ
	j0	L052
	push	1
	ret
	jmp	L053
L052:
	push	0
	ret
L053:
L021:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
L054:
	push	fp[0]
	push	3
	compLT
	j0	L055
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
	j0	L057
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
	j0	L058
	push	fp[1]
	ret
L058:
L057:
	jmp	L056
L056:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L054
L055:
	push	0
	pop	fp[0]
L059:
	push	fp[0]
	push	3
	compLT
	j0	L060
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
	j0	L062
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
	j0	L063
	push	fp[1]
	ret
L063:
L062:
	jmp	L061
L061:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L059
L060:
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
	j0	L064
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
	j0	L065
	push	fp[1]
	ret
L065:
L064:
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
	j0	L066
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
	j0	L067
	push	fp[1]
	ret
L067:
L066:
	push	0
	ret
L008:
	push	sp
	push	2
	add
	pop	sp
	push	0
	pop	fp[0]
	push	fp[0]
L068:
	push	fp[0]
	push	3
	compLT
	j0	L069
	push	0
	pop	fp[1]
	push	fp[1]
L071:
	push	fp[1]
	push	3
	compLT
	j0	L072
	push	10
	push	fp[0]
	push	3
	mul
	sub
	push	fp[1]
	sub
	push	1
	sub
	call	L041, 1
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
	jmp	L073
L073:
	push	fp[1]
	push	1
	add
	pop	fp[1]
	jmp	L071
L072:
	jmp	L070
L070:
	push	fp[0]
	push	1
	add
	pop	fp[0]
	jmp	L068
L069:
	push	0
	ret
L023:
	push	sp
	push	1
	add
	pop	sp
	push	"Player "
	puts_
	push	fp[-4]
	puti_
	push	" Do you want to retract? (y/n): "
	puts_
	getc
	pop	fp[0]
	push	fp[0]
	push	"Y"
	compEQ
	push	fp[0]
	push	'y'
	compEQ
	or
	j0	L074
	push	1
	ret
	jmp	L075
L074:
	push	0
	ret
L075:
L025:
	push	sp
	push	5
	add
	pop	sp
	push	0
	pop	fp[0]
	push	0
	pop	fp[1]
	push	fp[-4]
	j0	L076
	push	10
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	3
	mul
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	add
	push	1
	add
	sub
	pop	fp[0]
	push	10
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	3
	mul
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	add
	push	1
	add
	sub
	pop	fp[1]
	jmp	L077
L076:
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	3
	mul
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	add
	push	1
	add
	pop	fp[0]
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	3
	mul
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	add
	push	1
	add
	pop	fp[1]
L077:
	push	fp[0]
	call	L041, 1
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
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
	push	fp[1]
	call	L041, 1
	push	0
	push	0
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
	push	0
	push	1
	push	0
	pop	ac
	push	1
	mul
	push	ac
	add
	pop	ac
	push	2
	mul
	push	ac
	add
	pop	ac
	push	ac
	push	fp[-5]
	add
	pop	ac
	push	sb[ac]
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
