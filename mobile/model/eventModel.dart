class Event {
  int? eventID;
  int? societyID;
  String? eventName;
  String? eventDate;
  String? eventType;
  String? eventDescription;
  String? preferredVenue;
  String? societyName;

  Event({
    this.eventID,
    this.societyID,
    this.eventName,
    this.eventDate,
    this.eventType,
    this.eventDescription,
    this.preferredVenue,
    this.societyName,
  });

  Event.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    societyID = json['societyID'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventType = json['eventType'];
    eventDescription = json['eventDescription'];
    preferredVenue = json['preferredVenue'];
    societyName = json['societyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['eventID'] = eventID;
    result['societyID'] = societyID;
    result['eventName'] = eventName; // Updated
    result['eventDate'] = eventDate;
    result['eventType'] = eventType;
    result['eventDescription'] = eventDescription;
    result['preferredVenue'] = preferredVenue; // Updated
    result['societyName'] = societyName;
    return result;
  }
}
