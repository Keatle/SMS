import 'dart:convert';
import 'package:byte_blossoms/model/user_model.dart';
import 'package:byte_blossoms/storage/tokenStorage.dart';
import 'package:http/http.dart' as http;



class UserController {
  final TokenStorage storage = TokenStorage();
  
final String baseUrl = 'http/localhost:3006/';

  Future<http.Response> login({
    required String studentN,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/signin'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'studentN': studentN,
        'password': password,
      }),
    );

    print('Response status: ${res.statusCode}');
    print('Response body: ${res.body}');

    // Check if the login was successful and store the token that we retrieved
    if (res.statusCode == 200) {
      final resp = jsonDecode(res.body);
      print('Parsed response: $resp');
      await storage.writeToken(resp['token']);
    }
    
    return res;
  }

  Future<UserModel> createAccount({
    required String studentN,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/registrationUser");
    print('Sending request to: $url');
    print('Request body: ${jsonEncode(<String, String>{
      'studentN': studentN,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    })}');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'studentN': studentN,
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else {
      print('Failed to create account. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create account');
    }
  }

  Future<http.Response> getAuthenticatedRequest(String url) async {
    final token = await storage.readToken();
    return http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
