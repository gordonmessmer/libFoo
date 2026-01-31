#ifndef FOO_H
#define FOO_H

namespace geometry {

class Rectangle {
public:
    Rectangle(double width, double height);

    double perimeter() const;
    double area() const;

    double get_width() const;
    double get_height() const;

private:
    double width_;
    double height_;
};

} // namespace geometry

#endif /* FOO_H */
