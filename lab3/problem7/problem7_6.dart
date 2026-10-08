enum Result {
  success,
  error;

  static T getValue<T>(T value) {
    return value;
  }

  String message() {
    return switch (this) {
      Result.success => 'Success',
      Result.error => 'Error',
    };
  }
}

void main() {
  print(Result.success.message());

  int number = Result.getValue<int>(10);
  String text = Result.getValue<String>('Hello');

  print(number);
  print(text);
}