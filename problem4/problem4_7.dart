//problem 4.7 
T bigger<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) > 0 ? a : b;
}

void main() {
  print(bigger(10, 20));
}