class Person {
  String name;
  int age;

  Person(String name, int age)
      : name = name,
        age = _checkAge(age);

  static int _checkAge(int age) {
    if (age < 0 || age > 120) {
      throw ArgumentError('Invalid age');
    }

    return age;
  }
}

void main() {
  Person person = Person('Dilnavoz', 20);

  print(person.name);
  print(person.age);
}