Future<String> task1() async {
  await Future.delayed(Duration(seconds: 1));

  return 'Task 1';
}

Future<String> task2() async {
  await Future.delayed(Duration(seconds: 2));

  return 'Task 2';
}

Future<String> task3() async {
  await Future.delayed(Duration(seconds: 1));

  return 'Task 3';
}

void main() async {
  List<String> results = await Future.wait([
    task1(),
    task2(),
    task3()
  ]);

  print(results);
}