import 'package:shelf_plus/shelf_plus.dart';

class SecurityGate {
  final String _serverToken = 'Iufkn8n9gDZn8dkD9HzO1ejgri5oAR7aYClLSxWdwXfiR0pNpNoPwSpOIGOfvxhr';
  final _user = 'admin';
  final _password = '12345';

  String getToken(String user, String password) {
    if (user != _user || password != _password) {
      throw Exception('Credecias inválidas');
    }
    return _serverToken;
  }

  void isAuthorized(Request request) {
    final authorization = request.headers['authorization'];

    if (authorization == null) {
      throw Exception('A header authorization é obrigatória');
    }

    if (authorization != _serverToken) {
      throw Exception('Token inválido');
    }
  }
}
