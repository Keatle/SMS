import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestsPage extends StatefulWidget {
  final String societyID;

  RequestsPage({required this.societyID, required String userID});

  @override
  _RequestsPageState createState() => _RequestsPageState();
}
class _RequestsPageState extends State<RequestsPage> {
  late Future<List<dynamic>> _requests;

  @override
  void initState() {
    super.initState();
    _requests = fetchRequests(widget.societyID);
  }

  Future<List<dynamic>> fetchRequests(String societyID) async {
    final response = await http.get(Uri.parse('http://172.16.31.132:27/api/requests/pending/$societyID'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load requests');
    }
  }

  Future<void> updateRequestStatus(String requestID, String status) async {
    final response = await http.put(
      Uri.parse('http://172.16.31.132:27/api/requests/$requestID'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'requestStatus': status}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request $status successfully!')),
      );
      setState(() {
        _requests = fetchRequests("1");
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update request status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Requests'),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _requests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final requests = snapshot.data!;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return ListTile(
                  title: Text('Request from user: ${request['userID']}'),
                  subtitle: Text('Status: ${request['requestStatus']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => updateRequestStatus(request['requestID'], 'approved'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255), backgroundColor: Color.fromARGB(255, 248, 122, 12),
                        ),
                        child: Text('Approve'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => updateRequestStatus(request['requestID'], 'declined'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255), backgroundColor: Color.fromARGB(255, 248, 122, 12),
                        ),
                        child: Text('Decline'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}