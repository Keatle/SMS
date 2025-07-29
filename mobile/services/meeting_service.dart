import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:byte_blossoms/model/meetingModel.dart';

class AgendaService  {
 // static const String baseUrl = "http://10.254.157.186:27/api";
 static const String baseUrl = 'http://172.16.31.132:27/api/agenda'; // Update with your IP and port

//static const String baseUrl = 'http://10.254.46.24:33/agenda' ;  //uj address
 
  Future<List<AgendaData>> getAgendasByStudentNumber(String studentN) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getBSN/$studentN'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> agendasJson = jsonResponse['agendas'];
        return agendasJson.map((json) => AgendaData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load agendas: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch agendas: $e');
    }
  }
}