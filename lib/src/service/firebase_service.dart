import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';

class FirebaseService {
  Future<Document> getProject(String projectId) async =>
      await Firestore.instance.collection("projects").document(projectId).get();

  void createBlock(TabaBlockModel block) async =>
      await Firestore.instance.collection("pending-blocks").add(block.toJson());

  void pushBlock(TabaBlockModel block) async =>
      await Firestore.instance.collection("chain").add(block.toJson());
}
