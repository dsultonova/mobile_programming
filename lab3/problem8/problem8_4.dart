class Shape {
  void showShape() {
    print('Shape');
  }
}

class Polygon extends Shape {
  void showPolygon() {
    print('Polygon');
  }
}

class Triangle extends Polygon {
  void showTriangle() {
    print('Triangle');
  }
}

void main() {
  Triangle triangle = Triangle();

  triangle.showShape();
  triangle.showPolygon();
  triangle.showTriangle();
}