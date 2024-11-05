import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:taba_blockchain/src/common/firebase.dart';
import 'package:taba_blockchain/src/controller/chain_controller.dart';
import 'package:taba_blockchain/src/dto/request_create_transaction_dto.dart';
import 'package:taba_blockchain/src/middleware/cors/cors_middleware.dart';
import 'package:taba_blockchain/src/middleware/defaultcontenttype/default_content_type.dart';

// Controllers
ChainController _chainController = ChainController();

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(
        CorsMiddleware().handler,
      )
      .addMiddleware(
          DefaultContentType('application/json;charset=utf8').handler)
      .addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  // Initialize Firebase
  Firebase.initializeFirebase();

  print('Server listening on port ${server.port}');
}

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/api/create-transaction', _createTransaction)
  ..post('/api/approve-transaction', _approveTransaction);


Response _rootHandler(Request req) {
  return Response.ok(jsonEncode({"heloword": "success"}));
}

Future<Response> _createTransaction(Request req) async {
  try {
    final body = await req.readAsString();
    final requestJson = jsonDecode(body);
    final requestCreateTransactionDto =
        RequestCreateTransactionDto.fromJson(requestJson);

    _chainController.createTransaction(requestCreateTransactionDto.projectId,
        requestCreateTransactionDto.transaction);
    return Response.ok("Transação criada");
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}

Future<Response> _approveTransaction(Request req) async {
  try {
    final body = await req.readAsString();
    final requestJson = jsonDecode(body);

    _chainController.approveTransaction(
        requestJson['userId'], requestJson['projectId']);
    return Response.ok("Transação aprovada");
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}



