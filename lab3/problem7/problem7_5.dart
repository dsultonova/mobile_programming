enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday
}

void main() {
  String input = 'friday';

  try {
    Day day = Day.values.byName(input);

    print(day);
  } catch (e) {
    print('Invalid day');
  }
}