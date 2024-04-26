import 'package:shelf_multipart/form_data.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'security_gate.dart';

class LoginController extends SecurityGate {
  RouterPlus router;

  LoginController({required this.router}) {
    router.post('/login', login);
  }

  Future<Response> login(Request request) async {
    String token = "";

    final parameters = <String, String>{
      await for (final formData in request.multipartFormData) formData.name: await formData.part.readString(),
    };

    final user = parameters['user'];
    final password = parameters['password'];

    if (user == null || password == null) {
      return Response.forbidden('user and password are required');
    }

    try {
      token = getToken(user, password);
    } catch (e) {
      return Response.forbidden(e.toString());
    }

    return Response.ok(token);
  }
}
