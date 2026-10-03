interface class DBConnector {
  void connect() {
    print('Connecting...');
  }
}

class MySQLConnector implements DBConnector {
  @override
  void connect() {
    print('Connecting to MySQL');
  }
}

void main() {
  MySQLConnector database = MySQLConnector();

  database.connect();
}