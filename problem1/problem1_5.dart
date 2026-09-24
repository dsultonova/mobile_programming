
//problem 1.5
void main(List<String> arguments) {
  if (arguments.length != 2) {
    print('Usage: dart problem1.dart <arg1> <arg2>');
    return;
  }

  print('Argument 1: ${arguments[0]}');
  print('Argument 2: ${arguments[1]}');
}
