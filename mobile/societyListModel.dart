class Society {
  final int societyID;
  final String societyName;
  final String department;
  final String societyIcon;
  final String societyDescription;
  

  Society({
    required this.societyID,
    required this.societyName,
    required this.department,
    required this.societyIcon,
    required this.societyDescription,
    
  });

  factory Society.fromJson(Map<String, dynamic> json) {
    return Society(
      societyID: int.tryParse(json['societyID'].toString()) ?? 0,
      societyName: json['societyName'] ?? 'No Name Provided',
      department: json['department'] ?? '',
      societyIcon: json['societyIcon'] ?? '',
      societyDescription: json['societyDescription'] ?? 'DESCRIPTION',
    );
  }
}