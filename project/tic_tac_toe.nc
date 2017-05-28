// this is the demo code for game tic tac toe

// feature to show
// 1. multidimensional array
// 2. function
// 3. global varialbe
// 4. pass array and normal variable as arugments
// 5. basic control -> loop, branch, continue, break
// 6. function overloading
// 7. function use before definition without declaration


puts_("Starting...\n");
paramInit();
puts("Welcome to Tic-Tac-Toe!");
while(1){
	puts("Are you ready to play it? (y/n)");
	getc(cmd);
	gets(line); // chew up the newline char
	if (cmd == 'n' || cmd == 'N'){
		break;
	}
	oneGame();
	resetBoard();
}

puts("Bye!");


function oneGame(){
	puts("Game start!");
	for (i=0; i<9; i=i+1;){
		printBoard();
		puts_("Player ");
		puti_(i % 2 + 1);
		puts(": Give your choice [1-9]");
		valid = 0;
		choice = 0;
		while (1){
			geti(choice);
			valid = validate(choice);
			if (valid){
				break;
			}else{
				puts("Your choice is invalid, please choose again!");
			}
		}
		putOnBoard(i%2 + 1, choice);
		icon = checkWinIcon();
		if (icon == 'X'){
			@winner = 1;
			break;
		}else if (icon == 'O'){
			@winner = 2;
			break;
		}


	}
	if (@winner == 0){
		puts("Tie!");
	}else{
		if (@winner == 1){
			puts("Player 1 wins!");
		}else{
			puts("Player 2 wins!");
		}
	}
}



function paramInit(){
	@player = 0;
	@winner = 0;
	array @board[3][3];
	createBoard();
}

function createBoard(){
	i = 0;
	for (i;i<3;i=i+1;){
		j = 0;
		for (j;j<3;j=j+1;){
			@board[i][j] = itoa(i*3 + j + 1);
		}
	}
}

function resetBoard(){
	createBoard();
}
function itoa(i){
	array x[10];
	x[0] = '0';
	x[1] = '1';
	x[2] = '2';
	x[3] = '3';
	x[4] = '4';
	x[5] = '5';
	x[6] = '6';
	x[7] = '7';
	x[8] = '8';
	x[9] = '9';
	return x[i];
}

function printBoard(){
	putc('\n');
	printOneSlot(@Board[0][0]);
	putc_('|');
	printOneSlot(@Board[0][1]);
	putc_('|');
	printOneSlot(@Board[0][2]);
	puts("\n---+---+---");
	printOneSlot(@Board[1][0]);
	putc_('|');
	printOneSlot(@Board[1][1]);
	putc_('|');
	printOneSlot(@Board[1][2]);
	puts("\n---+---+---");
	printOneSlot(@Board[2][0]);
	putc_('|');
	printOneSlot(@Board[2][1]);
	putc_('|');
	printOneSlot(@Board[2][2]);
	putc('\n');
}

function printOneSlot(content){
	putc_(' ');
	putc_(content);
	putc_(' ');
}

function putOnBoard(player, choice){
	icon = 'X';
	if (player == 2){
		icon = 'O';
	}
	i = (choice - 1) / 3;
	j = (choice - 1) % 3;
	@Board[i][j] = icon;
}


// below are game logic functions

function validate(choice){
	// other invalid choices
	if (choice <1 || choice > 9){
		return 0;
	}
	i = (choice - 1) / 3;
	j = (choice - 1) % 3;
	if (@Board[i][j] == itoa(choice)){
		return 1;
	}else{
		return 0;
	}
}


function checkWinIcon(){
	// enumerate all lines
	for (i = 0; i < 3; i = i + 1;){
		if (@Board[i][0] == @Board[i][1]){
			check = @Board[i][0];
			if (check == @Board[i][2]){
				return check;
			}
		}
	}
	// enumerate all columns
	for (i = 0; i < 3; i = i + 1;){
		if (@Board[0][i] == @Board[1][i]){
			check = @Board[0][i];
			if (check == @Board[2][i]){
				return check;
			}
		}
	}

	// enumerate all cross
	if (@Board[0][0] == @Board[1][1]){
		check = @Board[0][0];
		if (check == @Board[2][2]){
			return check;
		}
	}
	if (@Board[0][2] == @Board[1][1]){
		check = @Board[0][2];
		if (check == @Board[2][0]){
			return check;
		}
	}
	return 0;
}

