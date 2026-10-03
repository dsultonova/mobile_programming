class Person {
  int _age = 0;

  int get age {
    return _age;
  }

  set age(int value) {
    if (value >= 0 && value <= 120) {
      _age = value;
    } else {
      print('Invalid age');
    }
  }
}

void main() {
  Person person = Person();

  person.age = 20;

  print(person.age);

  person.age = 150;
}