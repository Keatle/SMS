class UserModel {
  User? user;
  String? message;
  String? token;

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json.containsKey('user') && json['user'] != null
        ? User.fromJson(json['user'])
        : null;
    message = json['message'] ?? 'No message';
    token = json['token'] ?? 'No token';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (user != null) {
      result['user'] = user!.toJson();
    }
    result['message'] = message;
    result['token'] = token;
    return result;
  }
}

class User {
  int? userID;
  String? studentN;
  String? name;
  String? surname;
  String? email;
  String? password;
  String? userRole;

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'] ?? 0;
    studentN = json['studentN'] ?? 'No student number';
    name = json['name'] ?? 'No name';
    surname = json['surname'] ?? 'No surname';
    email = json['email'] ?? 'No email';
    password = json['password'] ?? 'No password';
    userRole = json['userRole'] ?? 'No role';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = <String, dynamic>{};
    res['userID'] = userID;
    res['studentN'] = studentN;
    res['name'] = name;
    res['surname'] = surname;
    res['email'] = email;
    res['password'] = password;
    res['userRole'] = userRole;
    return res;
  }
}
