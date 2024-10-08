import 'package:taba_blockchain/src/model/taba_block_model.dart';

abstract class TabaBlockchainRepoInterface {
  Future<dynamic> pushBlock(TabaBlockModel block);
  Future<dynamic> createBlock(TabaBlockModel block);
  Future<dynamic> getLastMinedBlock();
}
