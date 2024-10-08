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

  Future<Document?> getLastMainedBlock() async {
    // Referência para a coleção
    CollectionReference collection = Firestore.instance.collection('chain');

    // Consulta ordenando pelo timestamp em ordem decrescente e limitando a 1 documento
    var query = collection.orderBy('timestamp', descending: true).limit(1);

    // Executa a consulta
    List<Document> documents = await query.get();

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
}
