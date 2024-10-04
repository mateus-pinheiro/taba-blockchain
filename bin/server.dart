import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import '../lib/src/model/taba_blockchain_model.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/api/create-block', _mineBlock)
  ..get('/api/mine-block', _mineBlock);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _mineBlock(Request request) {
  try {
    var tabaBlockchainModel = TabaBlockchainModel();
    // createBlock();
    // tabaBlockchainModel.mineBlock(block);
    return Response.ok('');
  } catch (e) {
    return Response.badRequest();
  }

  // final message = request.params['message'];
  // return Response.ok('$message\n');
}

void createBlock(TabaBlockchainModel blockchain, body) {
  blockchain.createBlock(body);
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
