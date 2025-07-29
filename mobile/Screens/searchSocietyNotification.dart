import 'package:byte_blossoms/model/notificationModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationSearchPage extends StatefulWidget {
  @override
  _NotificationSearchPageState createState() => _NotificationSearchPageState();
}

class _NotificationSearchPageState extends State<NotificationSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<NotificationModel>>? _searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Notifications',
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
                  hintText: 'Search notifications',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 248, 122, 12)),
                    onPressed: _performSearch,
                  ),
                ),
                onSubmitted: (value) => _performSearch(),
              ),
            ),
            const 
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
        _searchResults = _fetchNotifications(query);
      });
    }
  }

Future<List<NotificationModel>> _fetchNotifications(String query) async 
{
  final url = Uri.parse('http://192.168.149.71:27/api/searchNotification');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'query': query}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    
    // Checking  if the response contains the 'societies' key.
    if (data is Map<String, dynamic> && data.containsKey('societies')) 
    {
      final List<dynamic> results = data['societies'];
      return results.map((json) => NotificationModel.fromJson(json)).toList();
    } 
    else 
    {
      throw Exception('Unexpected format of  data');
    }
  } 
  else 
  {
    throw Exception('Failed to load the notifications');
  }
}


  Widget _buildSearchResults() {
    return FutureBuilder<List<NotificationModel>>(
      future: _searchResults,
      builder: (context, snapshot) 
      {
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
          return Center(child: Text('No notifications found.'));
        } 
        else 
        {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) 
            {
              final notification = snapshot.data![index];
              return _buildNotificationTile(notification);
            },
          );
        }
      },
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) 
  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('http://192.168.149.71:27/${notification.societyID}'), 
            radius: 30,
          ),
          title: Text(notification.title),
          subtitle: Text(notification.createdAt),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.content,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
