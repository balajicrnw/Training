#include <stdio.h>
#include <string.h>

struct Student {
    char name[50];
    int age;
    float height;
};

void printStudentDetails(
    char* name,
    int age,
    float height
) {
    struct Student s;

    strcpy(s.name, name);

    s.age = age;

    s.height = height;

    printf("\nStudent Details\n");

    printf("Name: %s\n", s.name);

    printf("Age: %d\n", s.age);

    printf("Height: %.2f\n", s.height);
}