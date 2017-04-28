// test to generate fact.as

puts ("Please enter a +ve int < 13: ");
geti x;
puti fact(x);


function fact(a){
	if(a==1){
		return 1;
	}
	else{
		return fact(a-1)*a;
	}
}