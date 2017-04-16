// test to generate fact.as

print ("Please enter a +ve int < 13: ");
read x;
print fact(x);


fact(a){
	if(a==1){
		return 1;
	}
	else{
		return fact(a-1)*a;
	}
}