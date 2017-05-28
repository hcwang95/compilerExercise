//this program will use the algorithm of magic square to determine winner in a play
// declaration of functions



count=0;
count2=0;
array player1[5]=0, player2[5]=0;
size1=0;
size2=0;
array broad[3][3]=0;
garbage=-1;
mark1=0;
mark2=0;
draw=1;

array s[3][3]=0; //magic sqaure
s[0][0]=8;
s[0][1]=1;
s[0][2]=6;
s[1][0]=3;
s[1][1]=5;
s[1][2]=7;
s[2][0]=4;
s[2][1]=9;
s[2][2]=2;

bound="==============";
	
do{
	garbage=createBroad();
	while(count2<9){
	// player 1
	puts("Player1 - O");
	do
		geti(x);
	while((*(broad+x-1))!=0);
	player1[count]=(*(s+x-1)); // array can be treated by pointer
	(*(broad+x-1))=1;
	garbage=createBroad();
	count2=count2+1;
	if (subsetSum(1)==15){
		puts("Player 1 wins!");
		mark1=mark1+1;
		draw=0;
		break;
		}
	size1=size1+1;

	if(count2>=9)
		break;
	
	// player 2
	puts("Player2 - X");
	do
		geti(x);
	while(*(broad+x-1)!=0);
	player2[count]=*(s+x-1);
	*(broad+x-1)=2;
	garbage=createBroad();
	count2=count2+1;
	if (subsetSum(2)==15){
		puts("Player 2 wins!");
		mark2=mark2+1;
		draw=0;
		break;
		}
	size2=size2+1;
	count=count+1;
	}
	if(draw==1)
		puts("Draw!");
	puti("Player1: %d", mark1);
	puti("  vs  Player2: %d\n", mark2);
	puts("One more round?(1=yes)");
	geti(y);
	garbage=init();
}while(y==1);

createBroad(){
	c=1;
	for(i=0; i<3; i=i+1;){
		puts(@bound); //keyword @ to access global variable
		puts_("|");
		for(j=0; j<3; j=j+1;){
			if (@broad[i][j]==0)
				puti(" %d ", c);
			if (@broad[i][j]==1)
				puts_(" O ");
			if (@broad[i][j]==2)
				puts_(" X ");
			puts_("|");
			c=c+1;
		}
		puts_("\n");
	}
	puts(@bound);
	return -1;
}

subsetSum(player)
{
	if(player==1){
		if(@size1>=2)
		{
			for(i=@size1-1; i>=0; i=i-1;)
				for(j=i-1; j>=0; j=j-1;){
					if((@player1[i]+@player1[j]+@player1[@size1])==15)
						return 15;
				}
		}
	}
	if(player==2){
		if(@size2>=2)
		{
			for(i=@size2-1; i>=0; i=i-1;)
				for(j=i-1; j>=0; j=j-1;){
					if((@player2[i]+@player2[j]+@player2[@size2])==15)
						return 15;
				}
		}
	}
	return -1;
}

init(){
	@count=0;
	@count2=0;
	for (i=0;i<5;i=i+1;){
		@player1[i]=0;
		@player2[i]=0;
	}
	@size1=0;
	@size2=0;
	for (i=0;i<3;i=i+1;)
		for (j=0; j<3; j=j+1;)
			@broad[i][j]=0;
	@draw=1;
	return -1;
}