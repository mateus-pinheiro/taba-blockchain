import 'package:taba_blockchain/src/model/taba_block_model.dart';

abstract class TabaBlockchainRepoInterface {
  Future<dynamic> pushBlock(TabaBlockModel block);
  Future<dynamic> createBlock(TabaBlockModel block);
  Future<dynamic> getLastMinedBlock();
  Future<dynamic> getPendingBlockById(String blockId);
  Future<dynamic> updateBlock(String blockId, TabaBlockModel block);
  Future<dynamic> deletePendingBlock(String blockId);
  
}
