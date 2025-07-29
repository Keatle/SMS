import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';



class TokenStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: 'auth_token');
  }
}

class RegisterSocietyPage extends StatefulWidget {
  @override
  _RegisterSocietyPageState createState() => _RegisterSocietyPageState();
}

class _RegisterSocietyPageState extends State<RegisterSocietyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _societyDescriptionController = TextEditingController();
  final TextEditingController _societyNameController = TextEditingController();
  final TextEditingController _chairpersonController = TextEditingController();
  final TextEditingController _treasurerController = TextEditingController();
  final TextEditingController _secretaryController = TextEditingController();

  String? _selectedDepartment;
final String baseUrl = 'http/localhost:3006/';

  Uint8List? _societyIcon;
  Uint8List? _societyConstitution;
  Uint8List? _societyExecutiveList;
  Uint8List? _societyPetitionList;
  Uint8List? _societyYearPlan;
  Uint8List? _societyBudget;
  Uint8List? _societyPayment;

  String? _societyIconName;
  String? _societyConstitutionName;
  String? _societyExecutiveListName;
  String? _societyPetitionListName;
  String? _societyYearPlanName;
  String? _societyBudgetName;
  String? _societyPaymentName;

  Future<void> _pickFile(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          switch (type) {
            case 'icon':
              _societyIcon = result.files.single.bytes;
              _societyIconName = result.files.single.name;
              break;
            case 'constitution':
              _societyConstitution = result.files.single.bytes;
              _societyConstitutionName = result.files.single.name;
              break;
            case 'executiveList':
              _societyExecutiveList = result.files.single.bytes;
              _societyExecutiveListName = result.files.single.name;
              break;
            case 'petitionList':
              _societyPetitionList = result.files.single.bytes;
              _societyPetitionListName = result.files.single.name;
              break;
            case 'yearPlan':
              _societyYearPlan = result.files.single.bytes;
              _societyYearPlanName = result.files.single.name;
              break;
            case 'budget':
              _societyBudget = result.files.single.bytes;
              _societyBudgetName = result.files.single.name;
              break;
            case 'payment':
              _societyPayment = result.files.single.bytes;
              _societyPaymentName = result.files.single.name;
              break;
          }
          print('Picked file for $type: ${result.files.single.name}');
        });
      } else {
        print('No file selected for $type');
      }
    } catch (e) {
      print('Error picking file for $type: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking file for $type: $e'),
      ));
    }
  }

  Future<void> _registerSociety(BuildContext context) async {
    if (!_formKey.currentState!.validate() ||
        _societyIcon == null ||
        _societyConstitution == null ||
        _societyExecutiveList == null ||
        _societyPetitionList == null ||
        _societyYearPlan == null ||
        _societyBudget == null ||
        _societyPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete the form and upload all required files.'),
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
        Uri.parse('$baseUrl/regSocietyN'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['societyDescription'] = _societyDescriptionController.text;
      request.fields['societyName'] = _societyNameController.text;
      request.fields['department'] = _selectedDepartment ?? '';
      request.fields['chairperson'] = _chairpersonController.text;
      request.fields['treasurer'] = _treasurerController.text;
      request.fields['secretary'] = _secretaryController.text;

      request.files.add(http.MultipartFile.fromBytes(
        'societyIcon',
        _societyIcon!,
        filename: _societyIconName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyConstitution',
        _societyConstitution!,
        filename: _societyConstitutionName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyExecutiveList',
        _societyExecutiveList!,
        filename: _societyExecutiveListName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyPetitionList',
        _societyPetitionList!,
        filename: _societyPetitionListName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyYearPlan',
        _societyYearPlan!,
        filename: _societyYearPlanName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyBudget',
        _societyBudget!,
        filename: _societyBudgetName,
      ));
      request.files.add(http.MultipartFile.fromBytes(
        'societyPayment',
        _societyPayment!,
        filename: _societyPaymentName,
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);

        if (jsonResponse['success'] != null) {
          var insertId = jsonResponse['society'][0]['insertId'];
          print('Society registered with insert ID: $insertId');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Society Has Been Successfully Registered.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to register the society.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to register the society.'),
        ));
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during the registration.'),
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
          padding: EdgeInsets.all(16),
          backgroundColor: Color.fromARGB(139, 255, 165, 87),
          textStyle: TextStyle(fontSize: 16),
          minimumSize: Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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
                      style: TextStyle(fontSize: 14, color: Colors.white),
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
     backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Register Society",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 122, 12),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _societyNameController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Society Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the society name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  label: Text(
                    'Department',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                value: _selectedDepartment,
                items: <String>[
                  'Academics',
                  'Internationalisation',
                  'Social',
                  'Political',
                  'Religion',
                  'Culture',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _societyDescriptionController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Society Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the society description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _chairpersonController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Chairperson Student Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the chairperson\'s student number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _treasurerController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Treasurer Student Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the treasurer\'s student number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secretaryController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  label: Text(
                    'Secretary Student Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 122, 12),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the secretary\'s student number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildFilePickerButton(
                'Upload Society Icon',
                _societyIconName,
                () => _pickFile('icon'),
              ),
              _buildFilePickerButton(
                'Upload Society Constitution',
                _societyConstitutionName,
                () => _pickFile('constitution'),
              ),
              _buildFilePickerButton(
                'Upload Society Executive List',
                _societyExecutiveListName,
                () => _pickFile('executiveList'),
              ),
              _buildFilePickerButton(
                'Upload Society Petition List',
                _societyPetitionListName,
                () => _pickFile('petitionList'),
              ),
              _buildFilePickerButton(
                'Upload Society Year Plan',
                _societyYearPlanName,
                () => _pickFile('yearPlan'),
              ),
              _buildFilePickerButton(
                'Upload Society Budget',
                _societyBudgetName,
                () => _pickFile('budget'),
              ),
              _buildFilePickerButton(
                'Upload Proof of Payment',
                _societyPaymentName,
                () => _pickFile('payment'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerSociety(context),
                child: Text('Register Society'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: Color.fromARGB(255, 248, 122, 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
