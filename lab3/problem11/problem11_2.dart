Future<String> getUser() async {
  await Future.delayed(Duration(seconds: 2));

  return 'User #101';
}

void main() async {
  String user = await getUser();

  print(user);
}