//problem 3.6
void main() {
  dynamic data = {
    'type': 'user',
    'name': 'Dilnavoz'
  };

  switch (data) {
    case {'type': 'user', 'name': String name}:
      print('User: $name');
    default:
      print('Unknown');
  }
}