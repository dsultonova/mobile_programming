class Repository<T> {
  List<T> items = [];

  void add(T item) {
    items.add(item);
  }

  void showItems() {
    print(items);
  }
}

void main() {
  Repository<String> names = Repository<String>();

  names.add('Alice');
  names.add('Bob');

  names.showItems();
}