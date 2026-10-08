class Animal {
  void makeSound() {
    print('Animal sound');
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
}