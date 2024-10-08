import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/repository/blockchain/taba_blockchain_repo_interface.dart';
import 'package:taba_blockchain/src/service/firebase_service.dart';

class TabaBlockRepo implements TabaBlockchainRepoInterface {
  final FirebaseService _firebaseService = FirebaseService();
  
  @override
  Future createBlock(TabaBlockModel block) async {
    return _firebaseService.createBlock(block);
  }
  
  @override
  Future pushBlock(TabaBlockModel block) async {
    return _firebaseService.pushBlock(block);
  }
  
  @override
  Future getLastMinedBlock() {
    return _firebaseService.getLastMainedBlock();
  }
}
