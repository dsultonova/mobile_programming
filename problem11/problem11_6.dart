void main() {
  Stream<int> numbers = Stream.fromIterable([1, 2, 0, 4]);

  numbers
      .map((number) {
        if (number == 0) {
          throw Exception('Cannot use zero');
        }

        return 10 ~/ number;
      })
      .handleError((error) {
        print('Error: $error');
      })
      .listen((value) {
        print(value);
      });
}