// this is the demo code for game tic tac toe

// feature to show
// 1. multidimensional array                               ->@Board
// 2. function                                             ->anywhere
// 3. global varialbe                                      ->@Board
// 4. pass array and normal variable as arugments		   ->logic for retract
// 5. basic control -> loop, branch, continue, break       ->Game Logic
// 6. function overloading                                 ->createBoard
// 7. function use before definition without declaration   ->Most of the functions





// main function

puts_("Starting...\n");
paramInit();
puts("Welcome to Tic-Tac-Toe!");
count = 0;

while(1){
	puts("Are you ready to play it? (y/n)");
	getc(cmd);
	gets(line); // chew up the newline char
	if (cmd == 'n' || cmd == 'N'){
		break;
	}
	if (count % 2 == 0){
		reverse = 1;
	}else{
		reverse = 0;
	}
	oneGame(reverse);
	
	count = count +1;
}

puts("Bye!");


function oneGame(reverse){
	array retract[2][2] = -1;
	puts("Game start!");
	if (reverse){
		createBoard(reverse);
	}else{
		// function over
		createBoard();
	}
	for (i=0; i<9; i=i+1;){
		printBoard();
		puts_("Player ");
		puti_(i % 2 + 1);
		puts(": Give your choice [1-9]");
		valid = 0;
		choice = 0;
		while (1){
			geti(choice);
			valid = validate(choice, reverse);
			if (valid){
				break;
			}else{
				puts("Your choice is invalid, please choose again!");
			}
		}

		putOnBoard(i%2 + 1, choice, reverse, retract);
		icon = checkWinIcon();
		if (icon == 'X'){
			@winner = 1;
			if (checkRetract(2)){
				applyRetract(retract, reverse);
				@winner = 0;
				i = i-2;
				continue;
			}else{
				break;
			}
		}else if (icon == 'O'){
			@winner = 2;
			if (checkRetract(1)){
				applyRetract(retract, reverse);
				@winner = 0;
				i = i-2;
				continue;
			}else{
				break;
			}
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

function putOnBoard(player, choice, reverse, retract){
	icon = 'X';
	if (player == 2){
		icon = 'O';
	}
	if (reverse){
		choice = 10 - choice;
	}
	i = (choice - 1) / 3;
	j = (choice - 1) % 3;
	@Board[i][j] = icon;
	if (retract[0][0] == -1){
		retract[0][0] = i;
		retract[0][1] = j;
		
	}else if (retract[1][0] == -1){
		retract[1][0] = i;
		retract[1][1] = j;
	}else{
		retract[0][0] = retract[1][0];
		retract[0][1] = retract[1][1];
		retract[1][0] = i;
		retract[1][1] = j;
	}
		


}


// below are game logic functions

function validate(choice, reverse){
	// other invalid choices
	if (choice <1 || choice > 9){
		return 0;
	}
	if (reverse == 0){
		i = (choice - 1) / 3;
		j = (choice - 1) % 3;
	}else{
		i = (10 - choice -1) / 3;
		j = (10 - choice -1) % 3;
	}
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

// function overloading

function createBoard(reverse){
	i = 0;
	for (i;i<3;i=i+1;){
		j = 0;
		for (j;j<3;j=j+1;){
			@board[i][j] = itoa(10 - i*3 - j - 1);
		}
	}
}

// function for retracting 
function checkRetract(loser){
	printBoard();
	puts_("Player ");
	puti_(loser);
	puts_(": your opponent wins. Do you want to retract? (y/n): ");
	getc(option);
	if (option == "Y" || option == 'y'){
		return 1;
	}else{
		return 0;
	}
}

function applyRetract(retract, reverse){
	temp1 = 0;
	temp2 = 0;
	if (reverse){
		temp1 = 10 - (retract[0][0]*3 + retract[0][1] + 1);
		temp2 = 10 - (retract[1][0]*3 + retract[1][1] + 1);
	}else{
		temp1 = retract[0][0]*3 + retract[0][1] + 1;
		temp2 = retract[1][0]*3 + retract[1][1] + 1;
	}
	@Board[retract[0][0]][retract[0][1]] = itoa(temp1);
	@Board[retract[1][0]][retract[1][1]] = itoa(temp2);
}