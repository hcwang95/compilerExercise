// this is  the test code for c


void test(int(*)[10] x){
	printf("%d\n", x[2][2]);
}

int main(int argc, char const *argv[])
{
	int a[10][10], b[9][9];
	a[2][2] = 10;
	b[2][2] = 10;
	int c[1][10];
	c[2][2] = 0;
	printf("%d\n", a[2][2]);
	printf("%d\n", b[2][2]);
	// test(a);
	test(c);
	// test(b);
	return 0;
}

