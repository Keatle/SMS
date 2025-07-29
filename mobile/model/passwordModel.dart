class User {
  final int userID;
  final String currentPassword;
  final String newPassword;

  User({
    required this.userID,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
