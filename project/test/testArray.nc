array foo[9][22]; // defines a 2D array with indices 0..8, 0..21
array x[3], y[10][10][10];
// array z[100] = 0; // initialize all elements of z to 0

array ss[4];
foo[1][2] = 10;
y[2][3][4] = 10000000;
ss[2]=1111;
geti(ss[2]);
geti(y[2][3][4]);
puti(foo[1][2]);
puti(y[2][3][4]);
puti(ss[2]);

