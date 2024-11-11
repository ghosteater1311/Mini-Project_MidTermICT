#include <stdio.h>

int isPrime(int number)
{
    if (number == 2) return 1;
    if (number < 2 || number % 2 == 0) return 0;
    
    for (int i = 3; i * i <= number; i += 2)
    {
        if (number % i == 0) return 0;
    }
    
    return 1;
}