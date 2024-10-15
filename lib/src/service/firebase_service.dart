import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:taba_blockchain/src/model/taba_block_model.dart';
import 'package:taba_blockchain/src/model/taba_project_model.dart';

class FirebaseService {
  Future<Document> getProject(String projectId) async =>
      await Firestore.instance.collection("projects").document(projectId).get();

  void updateProject(String projectId, TabaProjectModel project) async =>
      await Firestore.instance
          .collection("projects")
          .document(projectId)
          .update(project.toJson());

  Future<Document> createBlock(TabaBlockModel block) async =>
      await Firestore.instance.collection("pending-blocks").add(block.toJson());

  void pushBlock(TabaBlockModel block) async =>
      await Firestore.instance.collection("chain").add(block.toJson());

  Future<Document> getBlockById(String id) async {
    return await Firestore.instance
        .collection('pending-blocks')
        .document(id)
        .get();
  }

  void updateBlock(String id, TabaBlockModel block) async {
    Firestore.instance
        .collection('pending-blocks')
        .document(id)
        .update(block.toJson());
  }

  Future<Document?> getLastMainedBlock() async {
    List<Document> documents = await Firestore.instance
        .collection('chain')
        .orderBy('header.timestamp', descending: true)
        .limit(1)
        .get();

    // Verifica se a consulta retornou algum documento
    if (documents.isNotEmpty) {
      // Obtém o primeiro (e único) documento da lista
      Document lastDocument = documents.first;
      // Acesse os dados do documento conforme necessário
      return lastDocument;
      // print('Último documento: ${lastDocument.data}');
    } else {
      return null;
    }
  }

  void deletePendingBlock(String blockId) {
    Firestore.instance.collection('pending-blocks').document(blockId).delete();
  }
}
