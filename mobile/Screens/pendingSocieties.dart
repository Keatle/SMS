import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/societyModel.dart';

class PendingSocieties extends StatefulWidget {
  final String userID;

  const PendingSocieties({Key? key, required this.userID}) : super(key: key);

  @override
  State<PendingSocieties> createState() => _PendingSocietiesState();
}

class _PendingSocietiesState extends State<PendingSocieties> {
  late Future<List<SocietyModel>> futureSocieties;
  List<SocietyModel> societies = [];
  List<SocietyModel> _filteredSocieties = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

final String baseUrl = 'http/localhost:3006/';

  @override
  void initState() {
    super.initState();
    futureSocieties = fetchPendingSocieties(widget.userID);
  }

  Future<List<SocietyModel>> fetchPendingSocieties(String userID) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pendingSocieties/$userID'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        societies = body.map((dynamic item) => SocietyModel.fromJson(item)).toList();
        setState(() {
          _filteredSocieties = societies;
          _isLoading = false;
        });
        return societies;
      } else {
        throw Exception('Failed to load pending societies');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      throw Exception('Failed to load pending societies: $e');
    }
  }

  void _searchSocieties(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredSocieties = societies;
      });
    } else {
      setState(() {
        _filteredSocieties = societies
            .where((society) =>
                society.societyName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSocieties.length,
                itemBuilder: (context, index) {
                  final society = _filteredSocieties[index];
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
                                    fontSize: 20.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  society.societyDescription ?? '',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Request Status: Pending",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black87,
                                  ),
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
}
