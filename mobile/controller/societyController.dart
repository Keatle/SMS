import 'dart:convert';
import 'package:byte_blossoms/model/societyModel.dart';
import 'package:http/http.dart' as http;


class SocietyController {
  final String baseUrl = "http://localhost:27/api";

  Future<SocietyModel> createApplication({
    required String societyDescription,
    required String societyName,
    required String department,
    required Map<String, String> uploadedFiles,
  }) async {
    final url = Uri.parse("$baseUrl/regSociety");

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    request.fields['societyID'] = societyDescription;
    request.fields['societyName'] = societyName;
    request.fields['department'] = department;

    try 
    {
      // Adding  the files from the uploadedFiles map
      for (var entry in uploadedFiles.entries) 
      {
        String fileType = entry.key;
        String filePath = entry.value;
        request.files.add(await http.MultipartFile.fromPath(fileType, filePath));
      }

      final response = await request.send();

      if (response.statusCode == 200) 
      {
        var jsonResponse = await response.stream.bytesToString();
        return SocietyModel.fromJson(jsonDecode(jsonResponse));
      } 
      else 
      {
        throw Exception('Failed to register the society. Status code for the error: ${response.statusCode}');
      }
    } 
    catch (error) 
    {
      throw Exception('Failed to send request to register the society: $error');
    }
  }
}