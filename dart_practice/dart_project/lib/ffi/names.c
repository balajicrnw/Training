#include <stdio.h>

// Print array of names
void printNames(char** names, int length) {
    printf("Names: ");

    for (int i = 0; i < length; i++) {
        if (i == 0) {
            printf("%s", names[i]);
        } else {
            printf(",%s", names[i]);
        }
    }
    printf("\n \n");
}