import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/attendanceModel.dart';

class AttendanceService {
  //static const baseUrl = 'http://10.254.46.24:33/eventattendance';  // (UJ Address) change address if stops displaying [@ shell :$ ipconfig] then look ( IPv4 Address) UJ

 // static const String baseUrl = "http://10.254.157.186:27/api/";
static const String baseUrl = 'http://172.16.31.132:27/api';  // (TheCampus Address) change address if stops displaying [@ shell :$ ipconfig] then look ( IPv4 Address)

    // Verify attendance code
  static Future<Map<String, dynamic>?> verifyAttendanceCode(String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // Record attendance
  static Future<bool> recordAttendance(int eventID, String studentN, String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/record'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'eventID': eventID, 'studentN': studentN, 'code': code}),
    );

    return response.statusCode == 201;
  }
}