import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/repository/taba_block_repo_interface.dart';

class TabaBlockRepo implements TabaBlockRepoInterface {
  @override
  Future insertBlock(TabaBlockModel block) {
    // TODO: persists on firebase firestore database
    throw UnimplementedError();
  }
}
