class AgendaData {
  final int agendaID;
  final int societyID;
  final String meetingTitle;
  final DateTime meetingDate;
  final DateTime meetingTime; // New field for meeting time
  final String? venue; // Renamed to match the SQL table column
  final String? agenda; // Renamed to match the SQL table column
  final String societyName; // This field seems relevant based on context

  AgendaData({
    required this.agendaID,
    required this.societyID,
    required this.meetingTitle,
    required this.meetingDate,
    required this.meetingTime, // New field required
    required this.venue, // Allow null value for venue
    required this.agenda, // Allow null value for agenda
    required this.societyName,
  });

  factory AgendaData.fromJson(Map<String, dynamic> json) {
    return AgendaData(
      agendaID: json['agendaID'],
      societyID: json['societyID'],
      meetingTitle: json['meetingTitle'] ?? 'Unknown Meeting',
      meetingDate: DateTime.tryParse(json['meetingDate'] ?? '') ?? DateTime.now(),
      meetingTime: DateTime.tryParse(json['meetingTime'] ?? '') ?? DateTime.now(), // Parse the time
      venue: json['Venue'] ?? 'No Venue', // Match the field name to SQL
      agenda: json['agenda'] ?? 'No Agenda Content', // Match the field name to SQL
      societyName: json['societyName'] ?? 'Unknown Society',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agendaID': agendaID,
      'societyID': societyID,
      'meetingTitle': meetingTitle,
      'meetingDate': meetingDate.toIso8601String(),
      'meetingTime': meetingTime.toIso8601String(),
      'Venue': venue,
      'agenda': agenda,
      'societyName': societyName,
    };
  }
}
