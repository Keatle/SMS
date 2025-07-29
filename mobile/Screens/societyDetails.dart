import 'package:byte_blossoms/model/societyListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/screens/societyRequirements.dart'; // Make sure this import matches your file structure


class SocietyDetailPage extends StatelessWidget {
  final Society society;

  SocietyDetailPage({required this.society});

  final storage = FlutterSecureStorage();

final String baseUrl = 'http/localhost:3006/';

  Future<void> _joinSociety(BuildContext context, String societyID) async {
    try {
      String? token = await storage.read(key: 'auth_token');
      String? userID = await storage.read(key: 'user_id');

      if (token == null || userID == null) {
        throw Exception('Authorization token or the user ID is not found');
      }

      final url = Uri.parse('$baseUrl/getRequirements/$societyID');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SocietyRequirementsPage(
              userID: userID,
              societyID: societyID,
            ),
          ),
        );
      } else {
        throw Exception('Failed to send join request');
      }
    } catch (e) {
      print('Error sending join request: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while sending join request: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = society.societyIcon.isNotEmpty
        ? 'http://10.254.46.24:27${society.societyIcon}'
        : 'https://www.bing.com/images/search?view=detailV2&ccid=CIcrk8bT&id=1DBF38ED8FC424AB6EC7AAFE4C43CCDF6FE0BF73&thid=OIP.CIcrk8bT06VP9hQVtg2e5wHaD4&mediaurl=https%3a%2f%2fstudentroom.co.za%2fwiki%2fwp-content%2fuploads%2f2020%2f12%2fuj-logo-1024x536.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.08872b93c6d3d3a54ff61415b60d9ee7%3frik%3dc7%252fgb9%252fMQ0z%252bqg%26pid%3dImgRaw%26r%3d0&exph=536&expw=1024&q=Uj+Logo+Ai&simid=608023235136462591&FORM=IRPRST&ck=9C1EE6267E80D67596E3983478F4AB10&selectedIndex=5&itb=0';

    return Scaffold(
      appBar: AppBar(
        title: Text(society.societyName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: 16.0),
            Text(
              society.societyName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              society.department,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                society.societyDescription,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 16.0),
            MaterialButton(
              minWidth: 150,
              height: 50,
              color: Color.fromARGB(255, 248, 122, 12),
              elevation: 1,
              onPressed: () => _joinSociety(context, society.societyID.toString()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "JOIN",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
