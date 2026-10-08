enum Day {
  monday,
  tuesday,
  wednesday
}

String getDayName(Day day) {
  return switch (day) {
    Day.monday => 'Monday',
    Day.tuesday => 'Tuesday',
    Day.wednesday => 'Wednesday',
  };
}

void main() {
  print(getDayName(Day.monday));
}