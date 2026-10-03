void main() {
  Stream<int> numbers = Stream.fromIterable([
    1, 1, 2, 2, 3, 4, 4
  ]);

  numbers
      .map((number) => number * 2)
      .where((number) => number > 2)
      .distinct()
      .listen((number) {
        print(number);
      });
}