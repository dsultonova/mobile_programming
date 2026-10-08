//problem 3.3
void main() {
  int number = 5;
  int factorial = 1;

  for (int i = 1; i <= number; i++) {
    factorial *= i;
  }

  print(factorial);

  for (int value in [1, 2, 3, 4, 5]) {
    print(value);
  }
}