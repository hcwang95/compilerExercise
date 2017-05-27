array foo[9][22]; // defines a 2D array with indices 0..8, 0..21
array x[3], y[10][10][10];

array ss[4];
foo[1][2] = 10;
y[2][3][4] = 10000000;
ss[2]=1111;
// array z[100] = ss[2]; // initialize all elements of z to 0

// geti(ss[2]);
// geti(y[2][3][4]);
puti(foo[1][2]);
puti(y[2][3][4]);
puti(ss[2]);
// puti(z[36]);
test();


function test(){
	array x[3];
	x[0] = 1;
	x[1] = 'c';
	x[2] = "tset";
	puti(x[0]);
	putc(x[1]);
	puts(x[2]);
	test1(x, @ss[2]);
}


// function test1(x, b){
// 	array x[3];
// 	puti(x[0]);
// 	putc(x[1]);
// 	puts(x[2]);	
// 	puti(b);
// }

// function test1(x, b){
// 	puti(x[0]);
// 	putc(x[1]);
// 	puts(x[2]);	
// 	puti(b);
// }

puti(ss[2]);