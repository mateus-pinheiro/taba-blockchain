import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firedart/firestore/models.dart';
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

    /// If blockId is empty or null, we'll create a new block for this project. If it is already exists, we'll just add an new transaction on the list inside of the block.
    if (project.blockId?.isEmpty ?? true) {
      var body = TabaBodyModel(
        project.needsApproval,
        projectId,
        transactions: [transaction],
      );

      var block = TabaBlockModel(TabaHeaderModel.newEmpty(), body: body);

      if (project.needsApproval) {
        Document document = await _blockRepo.createBlock(block);
        project.blockId = document.id;
        _projectRepo.updateProject(projectId, project);
      } else {
        var blockMined = await _mineBlock(block);
        if (blockMined != null) {
          _blockRepo.pushBlock(blockMined);
        }
      }
    } else {
      var block = await _getBlockById(project.blockId!);
      block.body.transactions.add(transaction);
      _blockRepo.updateBlock(project.blockId!, block);
    }
  }

  void approveTransaction(String userId, String projectId) async {
    var project = await _getProject(projectId);

    /// add user who approve to the list of approvers
    var block = await _getBlockById(project.blockId ?? "");
    block.body.approvers ??= <String>[];
    if (!block.body.approvers!.any((user) => user == userId)) {
      block.body.approvers!.add(userId);
    }
    _blockRepo.updateBlock(project.blockId ?? "", block);

    /// try to mine block
    var blockMined = await _mineBlock(block);
    if (blockMined != null) {
      await _blockRepo.pushBlock(blockMined).then((onSuccess) {
        project.blockId = blockMined.header.hash;
        _projectRepo.updateProject(projectId, project);
        _blockRepo.deletePendingBlock(project.blockId!);
      });
    }
  }

  Future<TabaProjectModel> _getProject(String projectId) async {
    Document projectFromService = await _projectRepo.getProject(projectId);
    return TabaProjectModel.fromMap(projectFromService.map);
  }

  Future<TabaBlockModel?> _mineBlock(TabaBlockModel block) async {
    if (paymentApproved(block)) {
      while (true) {
        final hash = _hash(block);
        if (hash.startsWith(proofOfWorkPrefix)) {
          block.header.hash = hash;

          /// get last block mined from chain to fill previous hash
          Document json = await _blockRepo.getLastMinedBlock();
          block.header.prevHash = TabaBlockModel.fromJson(json.map).header.hash;

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

  Future<TabaBlockModel> _getBlockById(String blockId) async {
    Document document = await _blockRepo.getPendingBlockById(blockId);
    return TabaBlockModel.fromJson(document.map);
  }
}
