import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: 'auth_token');
  }
}

class CreateRequirementPage extends StatefulWidget {
  final String userID;
  final String societyID;

  CreateRequirementPage({required this.userID, required this.societyID});

  @override
  _CreateRequirementPageState createState() => _CreateRequirementPageState();
}

class _CreateRequirementPageState extends State<CreateRequirementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _requirementTypeController = TextEditingController();
  final TextEditingController _requirementDescriptionController = TextEditingController();
  bool _requiresDocument = false;

  Uint8List? _requirementDocument;
  String? _requirementDocumentName;

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _requirementDocument = result.files.single.bytes;
          _requirementDocumentName = result.files.single.name;
        });
      } else {
        print('No document selected');
      }
    } catch (e) {
      print('Error picking document: $e');
    }
  }

  Future<void> _createRequirement(BuildContext context) async {
    if (!_formKey.currentState!.validate() || (_requiresDocument && _requirementDocument == null)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete the form and upload the required document if necessary.'),
      ));
      return;
    }

    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.16.31.132:27/api/createRequirement'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['userID'] = widget.userID;
      request.fields['societyID'] = widget.societyID;
      request.fields['requirementType'] = _requirementTypeController.text;
      request.fields['requirementDescription'] = _requirementDescriptionController.text;
      request.fields['requiresDocument'] = _requiresDocument.toString();

      if (_requiresDocument && _requirementDocument != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'requirementDocument',
          _requirementDocument!,
          filename: _requirementDocumentName,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);

        if (jsonResponse['success'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Requirement has been successfully created.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to create the requirement.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create the requirement.'),
        ));
      }
    } catch (e) {
      print('Error during requirement creation: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during the creation of the requirement.'),
      ));
    }
  }

  Widget _buildFilePickerButton(String buttonText, String? fileName, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 248, 122, 12), // Button color
        padding: EdgeInsets.symmetric(vertical: 15), // Padding inside button
        textStyle: TextStyle(fontSize: 16), // Text size
        minimumSize: Size(double.infinity, 60), // Make button full width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(buttonText),
          if (fileName != null)
            Text(
              fileName,
              style: TextStyle(color: Colors.grey), // Display file name in grey
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Requirement'),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _requirementTypeController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Requirement Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the requirement type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _requirementDescriptionController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Requirement Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the requirement description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SwitchListTile(
                title: Text('Requires Document'),
                value: _requiresDocument,
                onChanged: (bool value) {
                  setState(() {
                    _requiresDocument = value;
                  });
                },
                activeColor: Color.fromARGB(255, 248, 122, 12),
              ),
              SizedBox(height: 16),
              if (_requiresDocument)
                _buildFilePickerButton(
                  'Upload Requirement Document',
                  _requirementDocumentName,
                  _pickDocument,
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _createRequirement(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 248, 122, 12),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Create Requirement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
