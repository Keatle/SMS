class BudgetDetails {
  final String title;
  final String societyName;
  final String description;
  final String status;
  final DateTime createdAt;

  BudgetDetails({
    required this.title,
    required this.societyName,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory BudgetDetails.fromJson(Map<String, dynamic> json) {
    return BudgetDetails(
      title: json['Title'],
      societyName: json['SocietyName'],
      description: json['Description'],
      status: json['Status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'SocietyName': societyName,
      'Description': description,
      'Status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
