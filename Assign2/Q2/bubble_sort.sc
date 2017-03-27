// this is bubble sort for simple compiler
// initialize the array with ten elements
a[0] = 10;
a[1] = 1;
a[2] = 6;
a[3] = -4;
a[4] = 9;
a[5] = 15;
a[6] = 77;
a[7] = 46;
a[8] = -34;
a[9] = 0;

// real sorting part
for(x=0;x<10;x=x+1;){
	for(y=0;y<9;y=y+1;){
		if(a[y]>a[y+1]){
			t = a[y];
			a[y] = a[y+1];
			a[y+1] = t;
		}
	}
}

// print out the result
for(x=0;x<10;x=x+1;){
	print a[x];
}