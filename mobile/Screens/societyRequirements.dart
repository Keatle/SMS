import 'package:byte_blossoms/screens/colorProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart'; // Import this package for date formatting
import 'package:provider/provider.dart'; // Make sure to import the provider package

class TokenStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: 'auth_token');
  }
}

class SocietyRequirementsPage extends StatefulWidget {
  final String userID;
  final String societyID;

  SocietyRequirementsPage({required this.userID, required this.societyID});

  @override
  _SocietyRequirementsPageState createState() =>
      _SocietyRequirementsPageState();
}

class _SocietyRequirementsPageState extends State<SocietyRequirementsPage> {
  List<Map<String, dynamic>> _requirements = [];
  final String baseUrl = 'http/localhost:3006/';

  @override
  void initState() {
    super.initState();
    _fetchRequirements();
  }

  Future<void> _fetchRequirements() async {
    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      var response = await http.get(
        Uri.parse('$baseUrl/getRequirements/${widget.societyID}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _requirements = List<Map<String, dynamic>>.from(jsonResponse);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load requirements.'),
        ));
      }
    } catch (e) {
      print('Error fetching requirements: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while fetching requirements.'),
      ));
    }
  }

  Future<void> _uploadDocument(String requirementsID, String userID) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;

        if (file.path == null) {
          throw Exception('File path is null.');
        }

        var uri = Uri.parse('$baseUrl/uploadDocument/$requirementsID/$userID');
        var request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer ${await TokenStorage.readToken()}';

        request.files.add(await http.MultipartFile.fromPath(
          'file',
          file.path!,
          filename: file.name,
        ));

        request.fields['requirementsID'] = requirementsID;

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();

        print('Status Code: ${response.statusCode}');
        print('Response Body: $responseBody');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Document uploaded successfully.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to upload document: $responseBody'),
          ));
        }
      } else {
        throw Exception('No file selected.');
      }
    } catch (e) {
      print('Error during file upload: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during the upload. Error: $e'),
      ));
    }
  }

  Future<void> _submitTextFields(String requirementID, String userID, String textValue) async {
    var uri = Uri.parse('$baseUrl/submitText/$requirementID/$userID');
    var response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer ${await TokenStorage.readToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'textValue': textValue,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Text field data submitted successfully.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit text field data.'),
      ));
    }
  }



  // New buildHeader method
  Widget buildHeader() {
    final colorProvider = Provider.of<ColorProvider>(context); 
  
    return Container(
      color: colorProvider.headerColor, 
      height: 200, 
      width: 2200,
      padding: const EdgeInsets.only(top: 40, left: 10),
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
            "Requirements",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        
        ],
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[200],
    body: Column(
      children: [
        buildHeader(), // Use buildHeader here
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: _requirements.length,
              itemBuilder: (context, index) {
                final requirement = _requirements[index];
                Text(
                  requirement['requirementsType'] ?? 'No Requirement', // Provide a fallback
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 232, 232, 232),
                  ),
                );
                TextEditingController _textController = TextEditingController();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the name of the requirement
                      Text(
                        requirement['requirementsType'] ?? 'Requirement Name Not Available', // Fallback in case the value is null
                         style: const TextStyle(
                                    fontFamily: 'CustomFont',
                                    fontSize: 16.0,
                                   // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  
                                  
                      ),
                      SizedBox(height: 8),
                      // Checking if the document is required
                      requirement['requiresDoc'] == 1
                          ? ElevatedButton(
                              onPressed: () => _uploadDocument(
                                  requirement['requirementsID'].toString(),
                                  widget.userID),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                textStyle: TextStyle(fontSize: 16),
                                minimumSize: Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("Upload ${requirement['requirementsType'] ?? 'Requirement Name Not Available' }"),
                            )
                          : Column(
                              children: [
                                TextFormField(
                                  controller: _textController,
                                  style: TextStyle(
                                    fontFamily: 'CustomFont',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Enter ${requirement['requirementsType']}',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                    suffixIcon: Icon(Icons.check, color: Colors.grey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill in this requirement';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    _submitTextFields(
                                      requirement['requirementsID'].toString(),
                                      widget.userID,
                                      _textController.text,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    textStyle: TextStyle(fontSize: 16),
                                    minimumSize: Size(double.infinity, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
}