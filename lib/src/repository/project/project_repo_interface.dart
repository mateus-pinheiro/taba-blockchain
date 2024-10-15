import 'package:taba_blockchain/src/model/taba_project_model.dart';

abstract class ProjectRepoInterface {
  Future<dynamic> getProject(String projectId);
  Future<dynamic> updateProject(String projectId, TabaProjectModel project);
}
