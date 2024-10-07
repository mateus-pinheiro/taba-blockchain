import 'dart:io';

import 'package:firedart/firedart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:taba_blockchain/src/common/firebase.dart';
import 'package:taba_blockchain/src/controller/chain_controller.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/model/taba_blockchain_model.dart';
import 'package:taba_blockchain/src/model/taba_body_model.dart';
import 'package:taba_blockchain/src/model/taba_header_model.dart';
import 'package:taba_blockchain/src/model/taba_project_model.dart';
import 'package:taba_blockchain/src/model/taba_transaction_model.dart';

// Controllers
ChainController _chainController = ChainController();

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/api/create-transaction', _createTransaction)
  ..post('/api/approve-transaction', _approveTransaction)
  ..get('/api/chain', _getChain)
  ..get('/api/create-block', _createBlock)
  ..get('/api/mine-block', _mineBlock);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _mineBlock(TabaBlockModel block) {
  try {
    var tabaBlockchainModel = TabaBlockchainModel();
    // createBlock();

    return Response.ok('');
  } catch (e) {
    return Response.badRequest();
  }

  // final message = request.params['message'];
  // return Response.ok('$message\n');
}

// Future<TabaBlockModel> createBlock() async {
//   var projectId = "fNq9Be6zp9WF4FbjCCwM";
//   var firebaseResponse =
//       await Firestore.instance.collection("projects").document(projectId).get();
//   var project = Project.fromMap(firebaseResponse.map);
//   var transaction =
//       TabaTransactionModel(from: "mateus", to: "julio", amount: 10);
//   var header = TabaHeaderModel(
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//       hash: '',
//       prevHash: '',
//       nonce: 0);

//   var body = TabaBodyModel(project.needsApproval, projectId,
//       transactions: [transaction]);

//   return TabaBlockModel(header, body: body);
// }

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  //Initialize Firebase
  print("Firebase...");
  Firebase.initializeFirebase();
  print("Firebase inicializado");

  print('Server listening on port ${server.port}');
}

Future<Response> _createBlock(Request request) async {
  try {
    var map = await Firestore.instance.collection("teste").get();
    return Response.ok(map.first.toString());
  } catch (e) {
    return Response.badRequest();
  }
}

Future<Response> _createTransaction(Request req) async {
  // adicionar transação daquele usuario
  // criar o bloco com status pending daquele projeto, caso o bloco ainda não exista
  // se o bloco para aquele projeto, já existir, simplesmente atualiza a lista com transação nova

  try {
    // var projectId = req.body;
    // var transaction = req.body;
    
    // var block = await _chainController.createTransaction(projectId, transaction);

    // if (block.body.needsApproval) {
      
    //   Firestore.instance.collection("pending-blocks").add(block.toJson());
    // } else {
    //   _mineBlock(request);
    // }

    return Response.ok("Transação criada");
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}

Response _approveTransaction(Request req) {
  return Response.ok("Transação aprovada pelo usuario: ");
}

Response _getChain() {
  return Response.ok('');
}
