class Vehicle {
  String brand;

  Vehicle(this.brand);
}

class ElectricCar extends Vehicle {
  ElectricCar(super.brand);
}

void main() {
  ElectricCar car = ElectricCar('Tesla');

  print(car.brand);
}