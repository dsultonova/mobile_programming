void checkName(String? name) {
  if (name == null || name.isEmpty) {
    throw ArgumentError('Name cannot be empty');
  }

  print('Name: $name');
}

void main() {
  try {
    checkName('');
  } catch (e) {
    print('Error: $e');
  }
}