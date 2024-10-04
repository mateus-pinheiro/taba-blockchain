import 'dart:convert';

import 'taba_block_model.dart';
import 'taba_body_model.dart';
import 'taba_transaction_model.dart';
import 'taba_header_model.dart';
import 'package:crypto/crypto.dart';

class TabaBlockchainModel {
  final List<TabaBlockModel> _chain = [];
  late int _difficulty;

  TabaBlockchainModel({int difficulty = 4}) {
    _difficulty = difficulty;
    // _createGenesisBlock();
  }

  String get proofOfWorkPrefix {
    return '0' * _difficulty;
  }

  TabaBlockModel createBlock(TabaBodyModel body) {
    final block = TabaBlockModel(
      TabaHeaderModel(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        hash: '',
        nonce: 0,
        prevHash: _chain.isNotEmpty ? _chain.last.header.hash : '',
      ),
      body: body,
    );

    return block;
  }

  TabaBlockModel mineBlock(TabaBlockModel block) {
    while (true) {
      final hash = _hash(block);

      if (hash.startsWith(proofOfWorkPrefix)) {
        block.header.hash = hash;
        return block;
      }

      block.header.nonce++;
    }
  }

  void pushBlock(TabaBlockModel block) {
    final hash = _hash(block);

    if (!hash.startsWith(proofOfWorkPrefix)) {
      print('Não foi possível inserir o bloco');
      return;
    }

    _chain.add(block);
  }

  void printChain() {
    for (var element in _chain) {
      print(
          "-------------------- BLOCK hash: ${element.header.hash} -------------------");
      print(JsonEncoder().convert(element.toJson()));
      print("");
    }
  }

  void _createGenesisBlock() {
    final body = TabaBodyModel(
      false,
      "0",
      transactions: [TabaTransactionModel(from: '', to: 'teus', amount: 10000)],
    );

    final genesisBlock = TabaBlockModel(
      TabaHeaderModel(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        hash: '',
        nonce: 0,
        prevHash: '',
      ),
      body: body,
    );

    final minedBlock = mineBlock(genesisBlock);
    _chain.add(minedBlock);
  }

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
