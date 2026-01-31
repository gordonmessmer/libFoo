#include <iostream>
#include <string>
#include <iomanip>
#include "foo.h"

int main(int argc, char *argv[]) {
    if (argc != 4) {
        std::cerr << "Usage: " << argv[0] << " <width> <height> <perimeter|area>\n";
        return 1;
    }

    double width = std::stod(argv[1]);
    double height = std::stod(argv[2]);
    std::string operation = argv[3];

    geometry::Rectangle rect(width, height);

    if (operation == "perimeter") {
        double result = rect.perimeter();
        std::cout << "Perimeter: " << std::fixed << std::setprecision(2) << result << '\n';
    } else if (operation == "area") {
        double result = rect.area();
        std::cout << "Area: " << std::fixed << std::setprecision(2) << result << '\n';
    } else {
        std::cerr << "Invalid operation: " << operation << " (use 'perimeter' or 'area')\n";
        return 1;
    }

    return 0;
}
