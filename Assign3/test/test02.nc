// this is testing for 1. for loop 2. if else.

x = 's';

if (1>0){
	x = 10;
}

puti(x);

// in for loop all type updating should be unknown??

// check if the updating is the same as the original one,
// if the case then type remains the same, otherwise change to unknown

// same case happened in the if statement


// for (i=0;i<0;i=i+1;){
// 	x = 10;
// }
// putc(x);

x=20+10;
testFor(x);


function testFor(i){
	j = 10;
	k = 20;
	for (i;i<30;i=i+1;){
		if (i<k) return 0;
		if (i<j){
			return 20;
		}else{
			puts("here we do not exit");
		}
		i = 20;
		j = 30;
		k = 30;
		return (i+j+j+k);
	}
	puts("important");
	return 0;
}