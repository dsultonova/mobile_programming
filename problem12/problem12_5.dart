void divide() {
  int result = 10 ~/ 0;

  print(result);
}

void main() {
  try {
    divide();
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace:');
    print(stackTrace);
  }
}