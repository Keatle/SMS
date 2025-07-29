class MinutesModel {
  int? minutesID;
  int? societyID;
  String? meetingTitle; // New field to store the meeting title
  String? meetingDate; // New field to store the meeting date
  String? Venue; // New field to store the venue
  String? minutes; // New field to store the minutes text
  String? societyName; // Optional: Only include if needed for display, not in the DB schema

  MinutesModel({
    this.minutesID,
    this.societyID,
    this.meetingTitle,
    this.meetingDate,
    this.Venue,
    this.minutes,
    this.societyName, // This field is not part of the DB schema but can be useful for display
  });

  // Parsing JSON data into the MinutesData object
  MinutesModel.fromJson(Map<String, dynamic> json) {
    minutesID = json['minutesID'];
    societyID = json['societyID'];
    meetingTitle = json['meetingTitle'];
    meetingDate = json['meetingDate']; 
    Venue = json['Venue'];
    minutes = json['minutes'];
    societyName = json['societyName']; // Optional: Only include if needed for display
  }

}
