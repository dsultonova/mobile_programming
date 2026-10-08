class Animal {
  /// Old method that should no longer be used.
  @deprecated
  void oldSound() {
    print('Old sound');
  }

  /// Makes the animal sound.
  void makeSound() {
    print('Animal sound');
  }
}

class Dog extends Animal {
  /// Overrides the sound method from Animal.
  @override
  void makeSound() {
    print('Woof');
  }
}

void main() {
  Dog dog = Dog();

  dog.makeSound();
}