class RSVPData {
  int? rsvpID;
  int? studentID;
  int? eventID;
  bool? interest;

  RSVPData({this.rsvpID, this.studentID, this.eventID, this.interest});

  factory RSVPData.fromJson(Map<String, dynamic> json) {
    return RSVPData(
      rsvpID: json['rsvpID'],
      studentID: json['studentID'],
      eventID: json['eventID'],
      interest: json['interest'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['rsvpID'] = rsvpID;
    result['studentID'] = studentID;
    result['eventID'] = eventID;
    result['interest'] = interest == true ? 1 : 0;
    return result;
  }
}

class RSVPModel {
  List<RSVPData>? data;
  String? message;

  RSVPModel({this.data, this.message});

  factory RSVPModel.fromJson(Map<String, dynamic> json) {
    return RSVPModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => RSVPData.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    result['message'] = message;
    return result;
  }
}
