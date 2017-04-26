b = -10;
a = 10;
c = -10;

function abc(a){
	if (a == 10){
	 	return 10;
	}else{
		return abc(a+1)+a;
	}
	puti(a);
}


puti(abc(5));