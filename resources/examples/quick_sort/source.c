int arr[8] = {10, 10, 8, 9, 1, 2, 3, 0};
int n = 8;
int s = 4;

void swap(int* a, int* b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

int partition (int low, int high)
{
    int pivot = arr[high];
    int i = (low - 1);

    int j = 0;
    for (j = low; j <= high- 1; j=j+1)
    {
        if (arr[j] <= pivot)
        {
            i=i+1;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}


void quickSort(int low, int high)
{
    if (low < high)
    {
	    int pi = 0;
        pi = partition(low, high);

        quickSort(low, pi - 1);
        quickSort(pi + 1, high);
    }
}


void findTheSum()
{
    int i = 0;
    int j = n-1;

    while(i<j)
    {
        if(arr[i] + arr[j] == s)
        {
            printf("Numbers found ");
            print_int(arr[i]);
            printf(" + ");
            print_int(arr[j]);
            printf(" = ");
            print_int(s);
            i = n;
        }
        else
        {
            if(arr[i] + arr[j] < s)
            {
                i++;
            }
            else
            {
                j--;
            }
        }
    }
}

/* print array */
void printArray()
{
    int i;
    for (i=0; i < n; i=i+1)
    {
        print_int(arr[i]);
	    printf(" ");
    }
    printf("\n");
}

int main()
{
    printf("Array: ");
    printArray();
    quickSort(0, n-1);
    printf("Sorted array: ");
    printArray();
    findTheSum();
    return 0;
}

void print_int(int a){
	asm("li $v0 1");
	asm("syscall");
}