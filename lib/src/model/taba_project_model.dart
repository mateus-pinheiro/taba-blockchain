class TabaProjectModel {
  final String name;
  final String description;
  final bool needsApproval;
  final bool visible;
  String? blockId;

  TabaProjectModel({
    required this.name,
    required this.description,
    required this.needsApproval,
    required this.visible,
    this.blockId,
  });

  factory TabaProjectModel.fromMap(Map<String, dynamic> json) {
    return TabaProjectModel(
        name: json['name'],
        description: json['description'],
        needsApproval: bool.parse(json['needsApproval'].toString()),
        visible: bool.parse(json['visible'].toString()),
        blockId: json['blockId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'needsApproval': needsApproval,
      'visible': visible,
      'blockId': blockId,
    };
  }
}
