void divide() {
  try {
    int result = 10 ~/ 0;

    print(result);
  } catch (e) {
    print('Error inside divide()');

    rethrow;
  }
}

void main() {
  try {
    divide();
  } catch (e) {
    print('Error caught in main: $e');
  }
}