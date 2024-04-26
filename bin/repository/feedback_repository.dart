import '../models/feedback.dart';
import 'database.dart';

class FeedbackRepository extends Database {
  Future init() async {
    await initDatabase();
    await _createTable();
  }

  Future<void> _createTable() async {
    if (await _tableExists()) {
      return;
    }
    await connection.query('''
      CREATE TABLE feedback (
        id INT NOT NULL AUTO_INCREMENT,
        titulo VARCHAR(100) NOT NULL,
        descricao TEXT NOT NULL,
        tipo VARCHAR(100) NOT NULL,
        status VARCHAR(100) NOT NULL,
        PRIMARY KEY (id)
      )
    ''');
  }

  _tableExists() async {
    var result = await connection.query('SHOW TABLES LIKE "feedback"');
    return result.isNotEmpty;
  }

  getSelf() {
    return this as Feedback;
  }

  Future<void> save() async {
    if (!isInitialized) {
      await init();
    }

    await connection.query('''
      INSERT INTO feedback (titulo, descricao, tipo, status)
      VALUES (?, ?, ?, ?)
    ''', [getSelf().titulo, getSelf().descricao, getSelf().tipo, getSelf().status]);
  }

  Future<void> update() async {
    if (!isInitialized) {
      await init();
    }

    await connection.query('''
      UPDATE feedback
      SET titulo = ?, descricao = ?, tipo = ?, status = ?
      WHERE id = ?
    ''', [getSelf().titulo, getSelf().descricao, getSelf().tipo, getSelf().status, getSelf().id]);
  }

  Future<List<Feedback>> getAll() async {
    if (!isInitialized) {
      await init();
    }

    var result = await connection.query('SELECT * FROM feedback');
    return result
        .map((e) => Feedback()
          ..id = e[0]
          ..titulo = e[1].toString()
          ..descricao = e[2].toString()
          ..tipo = e[3].toString()
          ..status = e[4].toString())
        .toList();
  }

  Future<Feedback?> get(int id) async {
    if (!isInitialized) {
      await init();
    }

    var result = await connection.query('SELECT * FROM feedback WHERE id = ?', [id]);

    if (result.isEmpty) {
      return null;
    }

    return result
        .map((e) => Feedback()
          ..id = e[0]
          ..titulo = e[1].toString()
          ..descricao = e[2].toString()
          ..tipo = e[3].toString()
          ..status = e[4].toString())
        .first;
  }
}
