class Bird {
  void eat() {
    print('Eating');
  }
}

mixin Flyable on Bird {
  void fly() {
    print('Flying');
  }
}

class Eagle extends Bird with Flyable {
}

void main() {
  Eagle eagle = Eagle();

  eagle.eat();
  eagle.fly();
}