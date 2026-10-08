abstract class Describable {
  String get description;
}

enum Priority implements Describable {
  low,
  medium,
  high;

  @override
  String get description {
    return switch (this) {
      Priority.low => 'Low priority',
      Priority.medium => 'Medium priority',
      Priority.high => 'High priority',
    };
  }
}

void main() {
  print(Priority.high.description);
}