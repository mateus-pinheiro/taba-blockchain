class TabaProjectModel {
  final String name;
  final String description;
  final bool needsApproval;
  final bool visible;

  TabaProjectModel(
      {required this.name,
      required this.description,
      required this.needsApproval,
      required this.visible});

  factory TabaProjectModel.fromMap(Map<String, dynamic> json) {
    return TabaProjectModel(
        name: json['name'].toString(),
        description: json['description'].toString(),
        needsApproval: bool.parse(json['needsApproval'].toString()),
        visible: bool.parse(json['visible'].toString()));
  }
}
