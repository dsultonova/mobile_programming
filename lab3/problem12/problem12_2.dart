double divide(double a, double b) {
  if (b == 0) {
    throw UnsupportedError('Cannot divide by zero');
  }

  return a / b;
}

void main() {
  try {
    print(divide(10, 0));
  } catch (e) {
    print('Error: $e');
  }
}