int main()
{

    print_int(23+54*72-(82-91));

}


void print_int(int a)
{
	asm("li $v0 1");
	asm("syscall");
}