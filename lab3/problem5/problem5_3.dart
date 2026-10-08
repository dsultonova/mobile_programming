/// Checks whether an age is valid.
///
/// [age] is the age that will be checked.
///
/// Returns true if the age is between 0 and 120.
///
/// Throws [ArgumentError] if the age is negative.
bool isValidAge(int age) {
  if (age < 0) {
    throw ArgumentError('Age cannot be negative');
  }

  return age <= 120;
}

void main() {
  print(isValidAge(20));
}