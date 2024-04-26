import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'router/internal_router.dart';

void main(List<String> arguments) async {
  var router = Router().plus;

  InternalRouter(router: router);

  var app = Pipeline()
      .addMiddleware(
        logRequests(),
      )
      .addMiddleware(
        corsHeaders(),
      )
      .addHandler(router.call);

  var server = await io.serve(app, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}
