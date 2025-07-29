import 'dart:convert';
import 'package:http/http.dart' as http;import 'package:byte_blossoms/screens/createRequirements.dart';

class UserService {
  final String baseUrl = 'http/localhost:3006/';

  Future<int> fetchUnreadNotificationCount(String userID) async {
    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      final response = await http.get(Uri.parse('$baseUrl/notifications/unreadCount/$userID'),
          headers: {
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        
        return json.decode(response.body)['enreadCount'];
      } else {
        throw Exception('Failed to fetch unread notifications count');
      }
    } catch (e) {
      print('Error fetching unread notifications count: $e');
      return 0; 
    }
  }
}
