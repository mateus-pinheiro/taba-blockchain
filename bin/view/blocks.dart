// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as shelf_io;

// // void main() async {
// //   await initApp();
// // }

// void initApp() async {
//   final blockchain = Blockchain(difficulty: 5);

//   final body = Body(transactions: [
//     Transaction(from: 'sender1', to: 'receiver1', amount: 50),
//     Transaction(from: 'sender2', to: 'receiver2', amount: 30),
//   ]);

//   final block = blockchain.createBlock(body);
//   final minedBlock = blockchain.mineBlock(block);
//   blockchain.pushBlock(minedBlock);

//   final body2 = Body(transactions: [
//     Transaction(from: 'sender1', to: 'receiver1', amount: 23),
//     Transaction(from: 'sender2', to: 'receiver2', amount: 30),
//   ]);

//   final block2 = blockchain.createBlock(body2);
//   final minedBlock2 = blockchain.mineBlock(block2);
//   blockchain.pushBlock(minedBlock2);

//   blockchain.printChain();

//   // await initShelf(blockchain);
// }

// void initShelf(Blockchain blockchain) async {
//   var handler = const Pipeline()
//       .addMiddleware(logRequests())
//       .addHandler((request) => _handleRequest(request, blockchain));
//   var server = await shelf_io.serve(handler, 'localhost', 8080);
//   print('Serving at http://${server.address.host}:${server.port}');
// }

// Response _handleRequest(Request request, Blockchain blockchain) {
//   switch (request.url.path) {
//     case "/api/mine-block":
//       final minedBlock = blockchain.mineBlock(blockchain.createBlock(Body(transactions: [])));
//       blockchain.pushBlock(minedBlock);
//       return Response.ok(jsonEncode(minedBlock.toJson()));
//     default:
//       return Response.notFound('NotFound');
//   }
// }

// class Transaction {
//   final String from;
//   final String to;
//   final int amount;

//   Transaction({
//     required this.from,
//     required this.to,
//     required this.amount,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'from': from,
//       'to': to,
//       'amount': amount,
//     };
//   }
// }



// class Block {
//   late Map<String, dynamic> header;
//   late Body body;

//   Block(
//     this.header, {
//     required this.body,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'header': header,
//       'body': body.toJson(),
//     };
//   }
// }

// class Blockchain {
 
// }
