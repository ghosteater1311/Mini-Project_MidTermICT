#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main() {
    char A[32], B[32];
    int found;

    // Get input for strings A and B
    printf("Enter string A: ");
    fgets(A, sizeof(A), stdin);
    printf("Enter string B: ");
    fgets(B, sizeof(B), stdin);

    // Remove newline characters if present
    A[strcspn(A, "\n")] = '\0';
    B[strcspn(B, "\n")] = '\0';

    // Iterate through each character in A
    for (int i = 0; A[i] != '\0'; i++) {
        char ch = A[i];
        
        // Check if the character is a lowercase letter
        if (islower(ch)) {
            found = 0; // Flag to check if ch is in B

            // Search for ch in string B
            for (int j = 0; B[j] != '\0'; j++) {
                if (B[j] == ch) {
                    found = 1; // ch is found in B
                    break;
                }
            }

            // If ch was not found in B, print it
            if (!found) {
                putchar(ch);
            }
        }
    }

    putchar('\n'); // Print newline at the end
    return 0;
}
