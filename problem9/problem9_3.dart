mixin Flyable {
  void fly() {
    print('Flying');
  }
}

class Bird with Flyable {
}

void main() {
  Bird bird = Bird();

  bird.fly();
}