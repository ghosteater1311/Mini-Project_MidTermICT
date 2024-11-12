#include <stdio.h>
#include <stdlib.h>

int main()
{
    int arr[100];
    int i, n;
    int max_Adjacentcy_Sum = 0;
    
    scanf("%d", &n);
    for (i = 0; i < n; i++)
    {
        scanf("%d", &arr[i]);
    }

    max_Adjacentcy_Sum = arr[0] + arr[1];
    for (i = 0; i < n; i++)
    {
        if ((arr[i] + arr[i + 1]) > max_Adjacentcy_Sum) max_Adjacentcy_Sum = arr[i] + arr[i + 1];
    }

    printf("%d", max_Adjacentcy_Sum);
    return 0;
}