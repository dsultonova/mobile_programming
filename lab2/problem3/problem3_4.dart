//problem 3.4
void main() {
  int target = 5;
  int guess = 0;

  while (true) {
    print('Guess: $guess');

    if (guess == target) {
      print('Correct!');
      break;
    }

    guess++;
  }
}