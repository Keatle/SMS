import 'dart:convert';
import 'package:byte_blossoms/model/societyListModel.dart';
import 'package:byte_blossoms/screens/colorProvider.dart';
import 'package:byte_blossoms/screens/societyRequirements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final String baseUrl = 'http/localhost:3006/';

class SocietyListPage extends StatefulWidget {
  @override
  _SocietyListPageState createState() => _SocietyListPageState();
}

class _SocietyListPageState extends State<SocietyListPage> {
  List<Society> _societies = [];
  List<Society> _filteredSocieties = [];
  final TextEditingController _searchController = TextEditingController();
  final storage = FlutterSecureStorage();
  String selectedCategory = 'All'; 

  @override
  void initState() {
    super.initState();
    _fetchSocieties();
  }

  Future<void> _fetchSocieties() async {
    final url = Uri.parse('$baseUrl/approvedSociety');
    try {
      String? token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception('The token for authorization is not found');

      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          setState(() {
            _societies = data.map((json) => Society.fromJson(json)).toList();
            _filteredSocieties = _societies; // Initialize filtered list
          });
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load societies');
      }
    } catch (e) {
      print('Error fetching societies: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while fetching societies: $e'),
      ));
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      if (category == 'All') {
        _filteredSocieties = _societies;
      } else {
        _filteredSocieties = _societies.where((society) {
          return society.department.toLowerCase() == category.toLowerCase();
        }).toList();
      }
      selectedCategory = category;
    });
  }

  void _searchSocieties(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredSocieties = _societies;
      });
    } else {
      setState(() {
        _filteredSocieties = _societies
            .where((society) =>
                society.societyName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }


Future<void> _joinSociety(String societyID) async {
  try {
    String? token = await storage.read(key: 'auth_token');
    String? userID = await storage.read(key: 'user_id');

    if (token == null || userID == null) throw Exception('Authorization token or the user ID is not found');

    final url = Uri.parse('$baseUrl/getRequirements/$societyID');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      // Send join request regardless of whether there are requirements
      final requestUrl = Uri.parse('$baseUrl/requests');
      final requestResponse = await http.post(
        requestUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'userID': userID,
          'societyID': societyID,
          'requestStatus': 'pending',  // Request status as 'pending'
          'requestDate': DateTime.now().toString()
        }),
      );

      if (requestResponse.statusCode == 200) {
        // If there are requirements, navigate to the SocietyRequirementsPage
        if (data.isNotEmpty) {
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
          // If no requirements, you can handle the success (e.g., show a confirmation message)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request to join society sent successfully!')),
          );
        }
      } else {
        throw Exception('Failed to send join request.');
      }
    } else {
      throw Exception('Failed to fetch society requirements.');
    }
  } catch (e) {
    // Handle the error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}



Widget _buildHeader(double height, double width, BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); 
  
    String selectedCategory = 'All'; 

    return Container(
      color: colorProvider.headerColor,
      height: height * 0.25,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
            const Text(
              "Societies",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          /**  const Text(
            "Find your passion and be part of something great!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70, 
              fontStyle: FontStyle.italic, 
            ),
          ),*/
            const SizedBox(height: 10),
            // Dropdown for filtering categories
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: selectedCategory,
                  icon: const Icon(Icons.arrow_downward, color: Colors.white),
                  dropdownColor: colorProvider.headerColor, // Use dynamic dropdown color
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  items: <String>[
                    'All', 'Academic', 'Cultural', 'Internationalisation',
                    'Political', 'Religious', 'Social'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) _filterByCategory(newValue); // Replace with your filtering method
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search societies...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: Color.fromARGB(255, 248, 122, 12)),
          onPressed: () => _searchSocieties(_searchController.text),
        ),
      ),
      onChanged: (value) => _searchSocieties(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _buildHeader(height, width, context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchBar(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSocieties.length,
              itemBuilder: (context, index) {
                Society society = _filteredSocieties[index];
                final String imageUrl = society.societyIcon.isNotEmpty
                    ? '$baseUrl${society.societyIcon}'
                    : 'https://www.example.com/default_icon.jpg';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    subtitle: Text(society.department),
                    children: [
                      Card(
                        margin: const EdgeInsets.all(16.0),
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
                              const SizedBox(height: 16.0),
                              Text(
                                society.societyName,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                society.societyDescription ?? '',
                                textAlign: TextAlign.center,
                              ),
                              
                                SizedBox(height: 8.0),
                                MaterialButton(
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
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
