import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/minutesModel.dart';

class MinutesService {
  static const String _baseUrl = 'http://172.16.31.132:27/api'; // Update with your IP and port

  // Method to fetch minutes by a search query
  Future<List<MinutesModel>> searchMinutes(String query) async {
    final url = Uri.parse('$_baseUrl/ae');
    
    final response = await http.post(      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('minutes')) {
        final List<dynamic> results = data['minutes'];
        return results.map((json) => MinutesModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to load minutes');
    }
  }
}
