import 'package:firedart/firedart.dart';

const kFirebaseProjectId = "taba-blockchain";

class Firebase {
  static void initializeFirebase() {
    Firestore.initialize(kFirebaseProjectId);
  }

}
