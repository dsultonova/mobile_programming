//problem 4.4
List<int> transform(
  List<int> numbers,
  int Function(int) operation,
) {
  return numbers.map(operation).toList();
}

void main() {
  print(transform([1, 2, 3], (n) => n * 2));
}