abstract class Animal {
  void makeSound();

  void sleep() {
    print('Sleeping');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof');
  }
}

void main() {
  Dog dog = Dog();

  dog.makeSound();
  dog.sleep();
}