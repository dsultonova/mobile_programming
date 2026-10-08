void testError() {
  throw FormatException('Invalid format');
}

void main() {
  try {
    testError();
  } on FormatException catch (e) {
    print('Format error: $e');
  } catch (e) {
    print('Other error: $e');
  }
}