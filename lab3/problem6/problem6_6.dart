class User {
  final String name;
  final int age;

  const User(this.name, this.age);
}

void main() {
  const User user = User('Dilnavoz', 20);

  print(user.name);
  print(user.age);
}