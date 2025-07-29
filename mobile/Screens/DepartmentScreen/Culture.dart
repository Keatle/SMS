import 'dart:convert';
import 'package:byte_blossoms/screens/societyRequirements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:byte_blossoms/model/societyListModel.dart';


class CultureSocietiesList extends StatefulWidget {
  @override
  _CultureSocietiesListPageState createState() => _CultureSocietiesListPageState();
}

class _CultureSocietiesListPageState extends State<CultureSocietiesList> {
   List<Society> _societies = [];
  Map<int, bool> _expandedSocieties = {};

  @override
  void initState() {
    super.initState();
    _fetchSocieties();
  }

final String baseUrl = 'http/localhost:3006/';

  final storage = FlutterSecureStorage();

  Future<void> _fetchSocieties() async {
    final url = Uri.parse('$baseUrl/societies/culture');
    try {
      String? token = await storage.read(key: 'auth_token');

      if (token == null) {
        throw Exception('The token for authorization is not found');
      }

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the JSON structure contains the societies array
        if (data is Map<String, dynamic> && data.containsKey('societies')) {
          setState(() {
            _societies = (data['societies'] as List)
                .map((json) => Society.fromJson(json))
                .toList();
          });
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load societies');
      }
    } catch (e) {
      print('Error fetching societies: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while fetching societies: $e'),
        ),
      );
    }
  }

  void _toggleExpansion(int societyID) {
    setState(() {
      _expandedSocieties[societyID] = !(_expandedSocieties[societyID] ?? false);
    });
  }

  Future<void> _joinSociety(String societyID) async {
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
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while sending join request: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       backgroundColor: Color.fromARGB(255, 245, 244, 244),
      

      body: ListView.builder(
        itemCount: _societies.length,
        itemBuilder: (context, index) {
          final society = _societies[index];
          final isExpanded = _expandedSocieties[society.societyID] ?? false;

          final String imageUrl = society.societyIcon.isNotEmpty
              ? '$baseUrl${society.societyIcon}${society.societyIcon}'
              : 'https://example.com/default_image.jpg'; // Default placeholder

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              collapsedBackgroundColor: Colors.white,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30,
              ),
              title: Text(society.societyName),
              onExpansionChanged: (bool expanded) {
                _toggleExpansion(society.societyID);
              },
              children: [
                Card(
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          society.societyName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          society.societyDescription,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: MaterialButton(
                                minWidth: 150,
                                height: 50,
                                color: Color.fromARGB(255, 248, 122, 12),
                                elevation: 1,
                                onPressed: () => _joinSociety(society.societyID.toString()),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
