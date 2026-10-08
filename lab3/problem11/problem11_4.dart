import 'dart:async';

void main() {
  int count = 0;

  late StreamSubscription subscription;

  subscription = Stream.periodic(
    Duration(seconds: 1),
    (number) => number + 1,
  ).listen((value) {
    print('Tick: $value');

    count++;

    if (count == 5) {
      subscription.cancel();
      print('Stream cancelled');
    }
  });
}