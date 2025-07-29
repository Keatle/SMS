class NotificationModel {
  final int noticeID;
  final int societyID;
  final String title;
  final String content;
  final String createdAt;
  final String societyName;
   bool isRead;

  NotificationModel({
    required this.noticeID,
    required this.societyID,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.societyName,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      noticeID: json['noticeID'] ?? 0,
      societyID: json['societyID'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      societyName: json['society_name'] ?? '',
      isRead: json['isRead'] == "true" || json['isRead'] == true ? true : false,


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noticeID': noticeID,
      'societyID': societyID,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'societyName': societyName,
      'isRead': isRead ? 1 : 0,  
    };

  
}

}
