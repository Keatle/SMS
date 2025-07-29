class User {
  final int? userID;
  final String? name;
  final String? surname;

  User({this.userID, this.name, this.surname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      name: json['name'],
      surname: json['surname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'surname': surname,
    };
  }
}

