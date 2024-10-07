import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/model/taba_body_model.dart';
import 'package:taba_blockchain/src/model/taba_header_model.dart';
import 'package:taba_blockchain/src/model/taba_project_model.dart';
import 'package:taba_blockchain/src/model/taba_transaction_model.dart';
import 'package:taba_blockchain/src/service/firebase_service.dart';

class ChainController {
  final FirebaseService _firebaseService = FirebaseService();

  void mineBlock(TabaBlockModel block) {}

  void createTransaction(
      String projectId, TabaTransactionModel transaction) async {
    var projectFromService = await _getProject(projectId);
    var project = TabaProjectModel.fromMap(projectFromService.map);

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
      var blockMined = _mineBlock(block);
      _pushBlock(block);
    }
  }

  void _createBlock(TabaBlockModel block) async =>
      _firebaseService.createBlock(block);

  void _pushBlock(TabaBlockModel block) async =>
      _firebaseService.pushBlock(block);

  Future<Document> _getProject(String projectId) async =>
      await _firebaseService.getProject(projectId);

  void _mineBlock(TabaBlockModel block) async {
    
  }
}
