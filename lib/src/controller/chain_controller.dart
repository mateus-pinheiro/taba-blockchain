import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:taba_blockchain/src/common/blockchain.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/model/taba_body_model.dart';
import 'package:taba_blockchain/src/model/taba_header_model.dart';
import 'package:taba_blockchain/src/model/taba_project_model.dart';
import 'package:taba_blockchain/src/model/taba_transaction_model.dart';
import 'package:taba_blockchain/src/service/firebase_service.dart';

class ChainController {
  final FirebaseService _firebaseService = FirebaseService();

  void createTransaction(
      String projectId, TabaTransactionModel transaction) async {
    var project = await _getProject(projectId);

    // var transaction =
    //     TabaTransactionModel(from: "mateus", to: "julio", amount: 10);

    var header = TabaHeaderModel(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        hash: '',
        prevHash: '',
        nonce: 0);

    var body = TabaBodyModel(project.needsApproval, projectId,
        transactions: [transaction]);

    var block = TabaBlockModel(header, body: body);

    if (block.body.needsApproval) {
      _createBlock(block);
    } else {
      var blockMined = await _mineBlock(block);
      if (blockMined != null) {
        _pushBlock(blockMined);
      }
    }
  }

  void approveTransaction(String userId, String blockDocumentId) {
    // adicionar lista de users aprovados na lista de approvers
    // tentar mineirar bloco
  }

  void _createBlock(TabaBlockModel block) async =>
      _firebaseService.createBlock(block);

  void _pushBlock(TabaBlockModel block) async =>
      _firebaseService.pushBlock(block);

  void _getChain() => _firebaseService.getLastItemFromChain();

  Future<TabaProjectModel> _getProject(String projectId) async {
    var projectFromService = await _firebaseService.getProject(projectId);
    return TabaProjectModel.fromMap(projectFromService.map);
  }

  Future<TabaBlockModel?> _mineBlock(TabaBlockModel block) async {
    if (paymentApproved(block)) {
      while (true) {
        final hash = _hash(block);
        if (hash.startsWith(proofOfWorkPrefix)) {
          block.header.hash = hash;
          // get last item from chain to fill previous hash
          return block;
        }

        block.header.nonce++;
      }
    } else {
      return null;
    }
  }

  bool paymentApproved(TabaBlockModel block) => block.body.isApproved();

  String _hash(TabaBlockModel block) {
    var hashString = '';

    hashString += jsonEncode(block.body.toJson());
    hashString += block.header.prevHash.toString();
    hashString += block.header.timestamp.toString();
    hashString += block.header.nonce.toString();

    final hash = sha256.convert(utf8.encode(hashString)).toString();
    return hash;
  }
}
