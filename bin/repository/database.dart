import 'package:mysql1/mysql1.dart';

class Database {
  final String databaseName = 'feedbackuser';
  late ConnectionSettings _settings;
  late MySqlConnection _connection;
  bool isInitialized = false;

  MySqlConnection get connection => _connection;

  initDatabase() async {
    _settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
    );
    _connection = await MySqlConnection.connect(_settings);
    await createDatabase();
    await useDatabase();
    isInitialized = true;
  }

  createDatabase() async {
    await _connection.query('CREATE DATABASE IF NOT EXISTS $databaseName');
  }

  useDatabase() async {
    await _connection.query('USE $databaseName');
  }

  dispose() {
    _connection.close();
  }
}
