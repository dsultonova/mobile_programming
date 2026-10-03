class Dog {
  void bark() {
    print('Woof');
  }
}

class Cat {
  void meow() {
    print('Meow');
  }
}

void main() {
  dynamic animal = Dog();

  if (animal is Dog) {
    print('This is a Dog');

    Dog dog = animal;
    dog.bark();
  }
}