/// A simple calculator for basic mathematical operations.
class Calculator {
  /// Adds [a] and [b].
  ///
  /// Returns the sum of the two numbers.
  int add(int a, int b) {
    return a + b;
  }

  /// Divides [a] by [b].
  ///
  /// Returns the result of the division.
  ///
  /// Throws [ArgumentError] if [b] is zero.
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero');
    }

    return a / b;
  }
}

void main() {
  Calculator calculator = Calculator();

  print(calculator.add(10, 5));
  print(calculator.divide(10, 2));
}