import 'dart:ffi';

class ProfileModel {

  int? userID;
  String? gender;
  String? race;
  String? proofOfReg;
  String? religion;
  String? hobbies;
  String? age;
  String? campus;


  ProfileModel({
    this.userID,
    this.gender,
    this.race,
    this.proofOfReg,
    this.religion,
    this.hobbies,
    this.age,
    this.campus,
    
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    
    userID = json['userID'];
    gender = json['gender'];
    race = json['race'];
    proofOfReg = json['proofOfReg'];
    religion = json['religion'];
    hobbies = json['hobbies'];
    age = json['age'];
    campus = json['campus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = <String, dynamic>{};
   
    res['userID'] = userID;
    res['gender'] = gender;
    res['race'] = race;
    res['socproofOfRegietyIcon'] = proofOfReg;
    res['religion'] = religion;
    res['hobbies'] = hobbies;
    res['age'] = age;
    res['campus'] = campus;
    return res;
  }
}
