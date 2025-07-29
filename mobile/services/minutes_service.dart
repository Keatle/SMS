import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/minutesModel.dart';

class MinutesService {
 // static const String _baseUrl = "http://10.254.157.186:27/api";
 static const String _baseUrl = 'http://172.16.31.132:27/api'; // Update with your IP and port
 // static const String _baseUrl = 'http://10.254.46.24:33';

  Future<List<MinutesModel>> getMinutesByStudentNumber(String studentN) async {
    final response = await http.get(Uri.parse('$_baseUrl/getBSN/$studentN'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['nextStatus']) {
        final List<dynamic> minutes = data['minutes'];
        return minutes.map((json) => MinutesModel.fromJson(json)).toList();
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load minutes by student number');
    }
  }

}
