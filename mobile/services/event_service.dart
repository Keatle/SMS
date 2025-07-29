import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/eventModel.dart';

class EventService {
  //static const String baseUrl = 'http://10.254.46.24:33/events/getBSN'; // Update this URL to match your actual endpoint

  //static const String baseUrl = "http://10.254.157.186:27/api/events/getBSN"; 
  static const String baseUrl = 'http://172.16.31.132:27/api/events/getBSN';  // (TheCampus Address) change address if stops displaying [@ shell :$ ipconfig] then look ( IPv4 Address)

  Future<List<Event>> fetchEventsByStudentN(String studentN) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$studentN'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isEmpty) {
          print('No upcoming events');
          return [];
        }
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }
}