abstract class Animal {
  void makeSound();
}

class Dog implements Animal {
  @override
  void makeSound() {
    print('Woof');
  }
}

mixin Walkable {
  void walk() {
    print('Walking');
  }
}

class Cat with Walkable {
}

void main() {
  Dog dog = Dog();
  Cat cat = Cat();

  dog.makeSound();
  cat.walk();
}