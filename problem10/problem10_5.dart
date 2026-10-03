sealed class Result {
}

class Success extends Result {
  String message;

  Success(this.message);
}

class Error extends Result {
  String message;

  Error(this.message);
}

String getMessage(Result result) {
  return switch (result) {
    Success success => success.message,
    Error error => error.message,
  };
}

void main() {
  Result result = Success('Everything worked');

  print(getMessage(result));
}