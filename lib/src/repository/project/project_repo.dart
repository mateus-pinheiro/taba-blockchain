import 'package:taba_blockchain/src/repository/project/project_repo_interface.dart';
import 'package:taba_blockchain/src/service/firebase_service.dart';

class ProjectRepo implements ProjectRepoInterface {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Future getProject(String projectId) {
    return _firebaseService.getProject(projectId);
  }
}
