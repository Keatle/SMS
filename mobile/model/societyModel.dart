class SocietyModel {

  int? societyID;
  String? societyName;
  String? societyDescription;
  String? department;
  String? chairperson;
  String? treasurer;
  String? secreatry;
  String? societyIcon;
  String? societyConstitution;
  String? societyExecutiveList;
  String? societyPetitionList;
  String? societyYearPlan;
  String? societyBudget;
  String? societyPayment;
  String? societyStatus;

  SocietyModel({
    this.societyID,
    this.societyName,
    this.societyDescription,
    this.department,
    this.chairperson,
    this.treasurer,
    this.secreatry,
    this.societyIcon,
    this.societyConstitution,
    this.societyExecutiveList,
    this.societyPetitionList,
    this.societyYearPlan,
    this.societyBudget,
    this.societyPayment,
    this.societyStatus
  });

  SocietyModel.fromJson(Map<String, dynamic> json) {
    societyID = json['societyID'];
    societyName = json['societyName'];
    societyDescription = json['societyDescription'];
    department = json['department'];
    chairperson = json['chairperson'];
    treasurer = json['treasurer'];
    secreatry = json['secretary'];
    societyIcon = json['societyIcon'];
    societyConstitution = json['societyConstitution'];
    societyExecutiveList = json['societyExecutiveList'];
    societyPetitionList = json['societyPetitionList'];
    societyYearPlan = json['societyYearPlan'];
    societyBudget = json['societyBudget'];
    societyPayment = json['societyPayment'];
    societyStatus = json['societyStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = <String, dynamic>{};
   res['societyID'] = societyID;
    res['societyName'] = societyName;
    res['societyDescription'] = societyDescription;
    res['department'] = department;
    res['chairperson'] = chairperson;
    res['treasurer'] = treasurer;
    res['secretary'] = secreatry;
    res['societyIcon'] = societyIcon;
    res['societyConstitution'] = societyConstitution;
    res['societyExecutiveList'] = societyExecutiveList;
    res['societyPetitionList'] = societyPetitionList;
    res['societyYearPlan'] = societyYearPlan;
    res['societyBudget'] = societyBudget;
    res['societyPayment'] = societyPayment;
    res['societyStatus'] = societyStatus;
    return res;
  }
}
