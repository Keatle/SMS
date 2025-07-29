class EventAttendance {
  final int eventID;
  final String studentID;
  final String code;

  EventAttendance({
    required this.eventID,
    required this.studentID,
    required this.code,
  });

  factory EventAttendance.fromJson(Map<String, dynamic> json) {
    return EventAttendance(
      eventID: json['eventID'],
      studentID: json['memberID'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventID': eventID,
      'studentID': studentID,
    };
  }
}

class AttendanceCode {
  final String code;

  AttendanceCode({
    required this.code,
  });

  factory AttendanceCode.fromJson(Map<String, dynamic> json) {
    return AttendanceCode(
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
