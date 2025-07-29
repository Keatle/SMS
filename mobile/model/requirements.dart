class Requirement {
  final String id;
  final String type;
  final String description;
  final bool requiresDoc;

  Requirement({
    required this.id,
    required this.type,
    required this.description,
    required this.requiresDoc,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      id: json['requirementsID'],
      type: json['requirementsType'],
      description: json['reqDescription'],
      requiresDoc: json['requiresDoc'] == 1,
    );
  }
}
