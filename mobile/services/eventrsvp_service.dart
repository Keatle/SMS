import 'dart:convert';
import 'package:http/http.dart' as http;

class EventRSVPService {
 // final String baseUrl = "http://10.254.157.186:27/api";
final String baseUrl = 'http://172.16.31.132:27/api';
  //final String baseUrl = 'http://10.254.46.24:33';

  Future<void> confirmAttendance(int eventID, String studentN) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/confirm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'eventID': eventID, 'studentN': studentN}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to confirm attendance: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to confirm attendance: $e');
    }
  }

  Future<void> rejectAttendance(int eventID, String studentN) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reject'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'eventID': eventID, 'studentN': studentN}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to reject attendance: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to reject attendance: $e');
    }
  }
}
