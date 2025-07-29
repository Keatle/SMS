import 'package:byte_blossoms/Screens/member_noticeboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';



class ProfilePage extends StatefulWidget {
  final String userID;
  final String studentN;

  ProfilePage({required this.userID, required this.studentN});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _campusController = TextEditingController();

final String baseUrl = 'http/localhost:3006/';

  Uint8List? _proofOfReg;
  String? _proofOfRegName;

  final storage = FlutterSecureStorage();

  static const Color _primaryColor = Color.fromARGB(255, 248, 122, 12);

  @override
  void initState() {
    super.initState();
    // Initialize the _idController with the passed userID
    _idController.text = widget.userID;
  }

  Future<void> _pickFile(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          if (type == 'proofOfReg') {
            _proofOfReg = result.files.single.bytes;
            _proofOfRegName = result.files.single.name;
          }
          print('Picked file for $type: ${result.files.single.name}');
        });
      } else {
        print('No file selected for $type');
      }
    } catch (e) {
      print('Error picking file for $type: $e');
    }
  }

  Future<void> _createProfile(BuildContext context) async {
    if (!_formKey.currentState!.validate() || _proofOfReg == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please complete the form and upload the proof of registration.'),
      ));
      return;
    }

    try {
      final url = Uri.parse('$baseUrl/profile');
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        throw Exception('Authorization token not found');
      }

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['userID'] = _idController.text
        ..fields['gender'] = _genderController.text
        ..fields['race'] = _raceController.text
        ..fields['religion'] = _religionController.text
        ..fields['hobbies'] = _hobbiesController.text
        ..fields['age'] = _ageController.text
        ..fields['campus'] = _campusController.text
        ..files.add(http.MultipartFile.fromBytes(
          'proofOfReg',
          _proofOfReg!,
          filename: _proofOfRegName,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardStudent(userID: 'userID', studentN: 'studentN'),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile successfully created.'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create profile.'),
        ));
      }
    } catch (e) {
      print('Error during profile creation: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during profile creation.'),
      ));
    }
  }

  Widget _buildFilePickerButton(String label, String? fileName, Function() onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16), backgroundColor: _primaryColor,
          textStyle: TextStyle(fontSize: 16),
          minimumSize: Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ), // Apply the primary color
        ),
        child: Column(
          children: [
            Text(label),
            if (fileName != null) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      fileName,
                      style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 255, 255, 255)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Create Profile",
          style: TextStyle(
            color: Colors.white, // Set the title text color to white
          ),
        ),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
        iconTheme: IconThemeData(
          color: Colors.white, // Make the back arrow icon white
        ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'UserID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                readOnly: true, // Make the User ID field read-only
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Gender',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _raceController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Race',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your race';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _religionController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Religion',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your religion.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hobbiesController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Hobbies',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hobbies';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Age',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _campusController,
                decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Campus',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your campus';
                  }
                  return null;
                },
              ),
              _buildFilePickerButton(
                'Pick Proof of Registration',
                _proofOfRegName,
                () => _pickFile('proofOfReg'),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _createProfile(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16), backgroundColor: _primaryColor,
                    textStyle: TextStyle(fontSize: 16),
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ), 
                  ),
                  
                  child: Text('Create Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
