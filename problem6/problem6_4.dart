class Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal();

  void connect() {
    print('Connected to database');
  }
}

void main() {
  Database database1 = Database();
  Database database2 = Database();

  database1.connect();

  print(database1 == database2);
}