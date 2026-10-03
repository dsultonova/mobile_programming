class Person {
  String name;
  int age;

  Person(this.name, this.age);
}

void main() {
  Person person = Person('Dilnavoz', 20);

  print(person.name);
  print(person.age);
}