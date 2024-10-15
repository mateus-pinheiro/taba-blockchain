import 'package:taba_blockchain/src/model/taba_project_model.dart';
import 'package:taba_blockchain/src/repository/project/project_repo_interface.dart';
import 'package:taba_blockchain/src/service/firebase_service.dart';

class ProjectRepo implements ProjectRepoInterface {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Future getProject(String projectId) {
    return _firebaseService.getProject(projectId);
  }

  @override
  Future updateProject(String projectId, TabaProjectModel project) async {
    return _firebaseService.updateProject(projectId, project);
  }
}
