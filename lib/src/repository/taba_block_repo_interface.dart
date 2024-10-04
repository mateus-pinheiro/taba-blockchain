import 'package:taba_blockchain/src/model/taba_block_model.dart';

abstract class TabaBlockRepoInterface {
  Future<dynamic> insertBlock(TabaBlockModel block);
}
