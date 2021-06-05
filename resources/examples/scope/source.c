int i = 1;

int main()
{
    int i = 1;
    int b = 3;
    printf("i = 1\n");
    print_int(i);
    printf("\n");
    check();
    printf("b = 3\n");
    print_int(b);
    printf("\n");
    check2();
    return 0;
}

void check()
{
    printf("i = 1\n");
    print_int(i);
    printf("\n");
}

void check2()
{
    int b = 2;
    printf("b = 2\n");
    print_int(b);
    printf("\n");
}

void print_int(int a){
	asm("li $v0 1");
	asm("syscall");
}