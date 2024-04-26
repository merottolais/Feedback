import 'package:shelf_multipart/form_data.dart';
import 'package:shelf_plus/shelf_plus.dart';

import '../models/feedback.dart';
import '../repository/feedback_repository.dart';
import 'security_gate.dart';

class FeedbackController extends SecurityGate {
  RouterPlus router;
  FeedbackRepository repository = FeedbackRepository();

  FeedbackController({required this.router}) {
    router.get('/feedbacks', index);
    router.get('/feedbacks/<id>', show);
    router.post('/feedback/cadastrar', store);
    router.put('/feedback/atualizar/<id>', update);
  }

  Future<Map<String, dynamic>> index(Request request) async {
    try {
      isAuthorized(request);
    } catch (e) {
      return {'error': e.toString()};
    }

    return {'data': await repository.getAll()};
  }

  Future<Map<String, dynamic>> show(Request request, String id) async {
    try {
      isAuthorized(request);
    } catch (e) {
      return {'error': e.toString()};
    }

    return {'data': await repository.get(int.parse(id))};
  }

  Future<Response> store(Request request) async {
    final parameters = <String, String>{
      await for (final formData in request.multipartFormData) formData.name: await formData.part.readString(),
    };
    Feedback feedback = Feedback.fromJson(parameters);
    feedback.validate();
    await feedback.save();
    return Response.ok('Feedback cadastrado com sucesso');
  }

  Future<Response> update(Request request, String id) async {
    try {
      isAuthorized(request);
    } catch (e) {
      return Response.forbidden('Error: $e');
    }
    Feedback? feedback = await repository.get(int.parse(id));

    if (feedback == null) {
      return Response.notFound('Feedback não encontrado');
    }

    final parameters = request.url.queryParameters;

    if (parameters['status'] == null) {
      return Response.badRequest(body: 'Status é obrigatório');
    }

    feedback.status = parameters['status'] ?? feedback.status;
    await feedback.update();

    return Response.ok('Feedback atualizado com sucesso');
  }
}
