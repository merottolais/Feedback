import '../repository/feedback_repository.dart';

class Feedback extends FeedbackRepository {
  int id = 0;
  String titulo = '';
  String descricao = '';
  String tipo = '';
  String status = 'recebido';

  Feedback();

  Feedback.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descricao = json['descricao'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    data['tipo'] = tipo;
    data['status'] = status;
    return data;
  }

  validate() {
    if (titulo.isEmpty) {
      throw Exception('Título é obrigatório');
    }
    if (descricao.isEmpty) {
      throw Exception('Descrição é obrigatória');
    }
    if (tipo.isEmpty) {
      throw Exception('Tipo é obrigatório');
    }
  }
}
