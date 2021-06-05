int main()
{

	int j = 1;
	int i;
	for(i = 2; i <= 25; ++i)
	{
        while(j < i){
            printf("Sum = ");
            print_int(((2+(i-1)*j)/2)*i);
            printf("\n");
            ++j;
        }
	}

}


void print_int(int a)
{
	asm("li $v0 1");
	asm("syscall");
}