import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:taba_blockchain/src/middleware/middlewares.dart';

class CorsMiddleware extends Middlewares {
  final Map<String, String> headers = {
    'Access-Controll-Allow-Origin': '*',
    'Access-Controll-Allow-Methods': 'GET,POST,PATCH,PUT,DELETE,OPTIONS',
    'Access-Controll-allow-Header':
        '${HttpHeaders.contentTypeHeader},${HttpHeaders.authorizationHeader}'
  };

  @override
  Future<Response> execute(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response(
        HttpStatus.ok,
        headers: headers,
      );
    }
    final response = await innerhandler(request);
    return response.change(headers: headers);
  }
}
