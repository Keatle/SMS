import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/eventModel.dart';

class EventService {
  static const String baseUrl = 'http://172.16.31.132:27/api';

  Future<List<Event>> searchEvents(String query) async { // Changed method name to match the UI
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/searchEvent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['events'];

        if (data.isEmpty) {
          print('No events found');
          return [];
        }
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search events: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }
}
