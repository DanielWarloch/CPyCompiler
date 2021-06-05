int main()
{
	int n;
	n = 23;
	tree(n);
	return 0;
}

void tree(int n) {
	int j;
	int a;
	for (j = n; j > 0; j -= 2) {
		for (a = 0; a < n - j; a++)
			printf(" ");
		for (a = 0; a < j; a++)
			printf("* ");
		printf("\n");
	}
}