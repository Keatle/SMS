import 'package:byte_blossoms/Screens/societyDetailes.dart';
import 'package:byte_blossoms/model/societyListModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class SocietySearchPage extends StatefulWidget {
  @override
  _SocietySearchPageState createState() => _SocietySearchPageState();
}

class _SocietySearchPageState extends State<SocietySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Society>>? _searchResults;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(
        title:  const Text('Search Societies', 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
    ),
        ),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
        ),
        
         body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
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
                    onPressed: _performSearch,
                  ),
                ),
                onSubmitted: (value) => _performSearch(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() 
  {
    final query = _searchController.text;
    if (query.isNotEmpty) 
    {
      setState(() 
      {
        _searchResults = _fetchSocieties(query);
      });
    }
  }

  Future<List<Society>> _fetchSocieties(String query) async 
  {
    final url = Uri.parse('http://192.168.149.71:27/api/searchSociety');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) 
    {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('societies')) 
      {
        final List<dynamic> results = data['societies'];
        return results.map((json) => Society.fromJson(json)).toList();
      } 
      else 
      {
        throw Exception('Unexpected format of  data');
      }
    } 
    else 
    {
      throw Exception('Failed to load the societies');
    }
  }

  Widget _buildSearchResults() 
  {
    return FutureBuilder<List<Society>>(
      future: _searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) 
        {
          return Center(child: CircularProgressIndicator());
        } 
        else if (snapshot.hasError) 
        {
          return Center(child: Text('Error: ${snapshot.error}'));
        } 
        else if (!snapshot.hasData || snapshot.data!.isEmpty) 
        {
          return Center(child: Text('No societies found.'));
        } 
        else 
        {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final society = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('http://192.168.149.71:27${society.societyIcon}'),
                ),
                title: Text(society.societyName),
                subtitle: Text(society.department),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SocietyDetailPage(society: society),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
