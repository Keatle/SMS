import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/passwordModel.dart';

class UserService {
  
  //final String baseUrl = "http://10.254.157.186:27/api/cPass";
  final String baseUrl = 'http://172.16.31.132:27/api/cPass';
  //final String baseUrl = 'http://10.254.46.24:33/changePassword/cPass';

  Future<String> changePassword(User user) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body; // Return the response body directly
    } else {
      // Return error message from the response body
      final errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse);
    }
  }
}
