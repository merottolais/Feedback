import 'package:shelf_plus/shelf_plus.dart';

import '../controller/feedback_controller.dart';
import '../controller/login_controller.dart';

class InternalRouter {
  RouterPlus router;
  late FeedbackController feedController;
  late LoginController loginController;

  InternalRouter({required this.router}) {
    feedController = FeedbackController(router: router);
    loginController = LoginController(router: router);
    _exposeStaticFiles();
    router.all('/<ignored|.*>', _notFound);
  }

  _exposeStaticFiles() {
    Handler htmlHandler = createStaticHandler('bin/views', defaultDocument: 'formulario_view.html');
    router.get('/', htmlHandler);
    router.get('/<file|.*>', htmlHandler);
  }

  _notFound(Request request) {
    return Response.notFound('Not found');
  }
}
