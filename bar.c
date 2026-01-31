#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "foo.h"

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <width> <height> <perimeter>\n", argv[0]);
        return 1;
    }

    double width = atof(argv[1]);
    double height = atof(argv[2]);
    char *operation = argv[3];

    if (strcmp(operation, "perimeter") == 0) {
        double result = rectangle_perimeter(width, height);
        printf("Perimeter: %.2f\n", result);
    } else {
        fprintf(stderr, "Invalid operation: %s (use 'perimeter')\n", operation);
        return 1;
    }

    return 0;
}
