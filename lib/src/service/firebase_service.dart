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

  Future<Page> getLastItemFromChain() async {
    //TODO
    throw Exception();

  //   // Ordena pela data de criação (timestamp) em ordem decrescente e pega o primeiro
  //   var querySnapshot = await Firestore.instance
  //       .collection("chain")
  //       .orderBy('createdAt',
  //           descending: true) // Ordena do mais recente para o mais antigo
  //       .limit(1) // Limita a busca a um documento
  //       .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     // Obtém o último documento (na verdade o primeiro do resultado decrescente)
  //     DocumentSnapshot lastDocument = querySnapshot.docs.first;
  //     Map<String, dynamic>? data = lastDocument.data() as Map<String, dynamic>?;
  //     print("Último documento encontrado: ${data}");
  //   } else {
  //     print("Nenhum documento encontrado na coleção.");
  //   }
  }
}
