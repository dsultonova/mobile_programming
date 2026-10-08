//problem 3.5
void main() {
  outerLoop:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (j == 2) {
        continue;
      }

      if (i == 3) {
        break outerLoop;
      }

      print('$i $j');
    }
  }
}