int main(int argc, char const *argv[])
{
  int i,j,k;
  k = 1;
  for(i=1; i<100; i=i+k) {
  j=i;
  while(j > 0) {
    j = j / 2;
    if(j == 1)
  break;
  }
  if(i<10) {
    continue;
  }
  k=k+1;
  }

  printf("i:%d, j:%d, k:%d\n", i,j,k);
  return 0;
}