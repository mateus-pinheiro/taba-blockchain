class Project {
  final String name;
  final String description;
  final bool needsApproval;
  final bool visible;

  Project(
      {required this.name,
      required this.description,
      required this.needsApproval,
      required this.visible});

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
        name: json['name'].toString(),
        description: json['description'].toString(),
        needsApproval: bool.parse(json['needsApproval'].toString()),
        visible: bool.parse(json['visible'].toString()));
  }
}
