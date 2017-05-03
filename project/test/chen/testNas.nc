if('a' > 10){
	puti('1' + 1);
}else{
	puts("a is smaller than 10");
}
def func1(x){
	return 1;
}

def func2(x){
	return x== 1;
}

def func3(x,y){
	return ((x)) == y;
}

puti(func3(func1(1), func2(func1(10))));
