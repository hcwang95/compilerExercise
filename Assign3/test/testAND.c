#include <stdlib.h>

int main(int argc, char const *argv[])
{
	int* test;
	printf("%p\n", test);
	printf("%d\n",  test | (int*)NULL);
	return 0;
}