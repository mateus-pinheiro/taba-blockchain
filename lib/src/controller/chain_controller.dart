import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:taba_blockchain/src/common/blockchain.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/model/taba_body_model.dart';
import 'package:taba_blockchain/src/model/taba_header_model.dart';
import 'package:taba_blockchain/src/model/taba_project_model.dart';
import 'package:taba_blockchain/src/model/taba_transaction_model.dart';
import 'package:taba_blockchain/src/repository/blockchain/taba_blockchain_repo.dart';
import 'package:taba_blockchain/src/repository/blockchain/taba_blockchain_repo_interface.dart';
import 'package:taba_blockchain/src/repository/project/project_repo.dart';
import 'package:taba_blockchain/src/repository/project/project_repo_interface.dart';

class ChainController {
  final TabaBlockchainRepoInterface _blockRepo = TabaBlockRepo();
  final ProjectRepoInterface _projectRepo = ProjectRepo();

  void createTransaction(
      String projectId, TabaTransactionModel transaction) async {
    var project = await _getProject(projectId);
    var body = TabaBodyModel(
      project.needsApproval,
      projectId,
      transactions: [transaction],
    );

    var block = TabaBlockModel(TabaHeaderModel.newEmpty(), body: body);

    if (block.body.needsApproval) {
      _blockRepo.createBlock(block);
    } else {
      var blockMined = await _mineBlock(block);
      if (blockMined != null) {
        _blockRepo.pushBlock(blockMined);
      }
    }
  }

  void approveTransaction(String userId, String blockDocumentId) {
    // adicionar lista de users aprovados na lista de approvers
    // tentar mineirar bloco
  }

  Future<TabaProjectModel> _getProject(String projectId) async {
    var projectFromService = await _projectRepo.getProject(projectId);
    return TabaProjectModel.fromMap(projectFromService.map);
  }

  Future<TabaBlockModel?> _mineBlock(TabaBlockModel block) async {
    if (paymentApproved(block)) {
      while (true) {
        final hash = _hash(block);
        if (hash.startsWith(proofOfWorkPrefix)) {
          block.header.hash = hash;
          // get last item from chain to fill previous hash
          var json = await _blockRepo.getLastMinedBlock();
          TabaBlockModel.fromJson(json);
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
