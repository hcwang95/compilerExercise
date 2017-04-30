// this is one of the testing code


x = 20;
x = testing(x, 20);
puti(x);
puts("hello world!!");

function testing(i ,   j  ){
	puts("testing with two arguments");
	puti(i+j);
	geti(i);
	puti(i<j);
	return (testing(i,j,10));
}

function testing(a, b,   c   ){
	puts("here is testing with three arguments");
	return(a+b*c);
}


if (judge(x)){
	putc('\n');
}
else{
	puts("heiheihei");
}


function judge(miaomiaomiao){
	return miaomiaomiao < 20;
}



