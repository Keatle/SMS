import 'package:byte_blossoms/Screens/leaveSociety.dart';
import 'package:byte_blossoms/screens/colorProvider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/societyModel.dart';
import 'package:byte_blossoms/screens/leaveSociety.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JoinedSociety extends StatefulWidget {
  final String userID;
  final String studentN;

  const JoinedSociety({Key? key, required this.userID, required this.studentN}) : super(key: key);

  @override
  State<JoinedSociety> createState() => _JoinedSocietyState();
}

class _JoinedSocietyState extends State<JoinedSociety> {
  late Future<List<SocietyModel>> futureSocieties;
  List<SocietyModel> societies = [];
  List<SocietyModel> filteredSocieties = [];

  final TextEditingController searchController = TextEditingController();
final String baseUrl = 'http/localhost:3006/';
  String currentDate = DateFormat('MMMM d').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    futureSocieties = fetchJoinedSocieties(widget.userID);
    searchController.addListener(_filterSocieties);  // Attach listener for search
  }

  Future<List<SocietyModel>> fetchJoinedSocieties(String userID) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/studentsociety/$userID'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        societies = body.map((dynamic item) => SocietyModel.fromJson(item)).toList();
        filteredSocieties = societies;  // Initially show all societies
        return societies;
      } else {
        throw Exception('Failed to load joined societies');
      }
    } catch (e) {
      throw Exception('Failed to load joined societies: $e');
    }
  }

  void removeSociety(SocietyModel society) {
    setState(() {
      societies.remove(society);
      filteredSocieties.remove(society);
    });
  }

  void _filterSocieties() {
    String searchText = searchController.text.toLowerCase();
    setState(() {
      filteredSocieties = societies
          .where((society) =>
              society.societyName?.toLowerCase().contains(searchText) ?? false)
          .toList();
    });
  }

Widget _buildHeader(double height, double width, BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); // Access the ColorProvider
    String currentDate = DateFormat('MMMM d').format(DateTime.now()); // Format the current date

    return Container(
      color: colorProvider.headerColor, // Use the dynamic header color from the provider
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
              "Joined Societies",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
           const Text(
            "You're part of something special! Here are the societies you've joined.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70, 
              fontStyle: FontStyle.italic, 
            ),
          ),
          ],
        ),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Societies",
                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Color.fromARGB(255, 248, 122, 12)),
                    onPressed: () => _filterSocieties,
                  ),
              ),

            ),
          ),
          Expanded(
            child: FutureBuilder<List<SocietyModel>>(
              future: futureSocieties,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No societies joined'));
                } else {
                  return ListView.builder(
                    itemCount: filteredSocieties.length,
                    itemBuilder: (context, index) {
                      final society = filteredSocieties[index];
                      final String imageUrl = society.societyIcon?.isNotEmpty == true
                          ? '$baseUrl${society.societyIcon}'
                          : 'https://www.example.com/default_icon.jpg';

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
                          title: Text(society.societyName ?? ''),
                          subtitle: Text(society.department ?? ''),
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
                                      society.societyName ?? '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      society.societyDescription ?? '',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          minWidth: 150,
                                          height: 50,
                                          color: Color.fromARGB(255, 248, 122, 12),
                                          elevation: 1,
                                          onPressed: () {
                                            LeaveSociety(
                                              societyID: society.societyID.toString(),
                                              userID: widget.userID,
                                              context: context,
                                              onSocietyRemoved: () => removeSociety(society),
                                              society: society
                                            ).showLeaveDialog();
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            "Leave Society",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
