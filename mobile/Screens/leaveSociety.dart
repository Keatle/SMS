import 'package:byte_blossoms/model/societyModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String baseUrl = 'http/localhost:3006/';

class LeaveSociety {
  final String societyID;
  final String userID;
  final BuildContext context;
  final VoidCallback onSocietyRemoved;

  LeaveSociety({
    required this.societyID,
    required this.userID,
    required this.context,
    required this.onSocietyRemoved, required SocietyModel society,
  });

  final List<String> reasons = [
    'Time Constraints',
    'Change In Interest',
    'Graduation or Course Completion',
    'Personal Reasons',
    'Disagreement with Society Direction',
    'Fulfillment of Goals',
    'Seeking New Challenges',
    'Conflict Values',
  ];

  String? reasonSelected;

  Future<void> leaveSociety() async {
    if (reasonSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a reason for leaving.')),
      );
      return;
    }

    final url = Uri.parse('$baseUrl/leaveSociety/$societyID/$userID');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'reason': reasonSelected}),
      );

      if (response.statusCode == 200) {
        // Successfully left the society
        onSocietyRemoved(); // Notify removal
        showConfirmationDialog('Success', 'You have successfully left the society.');
      } else {
        // Failed to leave the society
        showConfirmationDialog('Error', 'Failed to leave the society.');
      }
    } catch (e) {
      // Error occurred
      showConfirmationDialog('Error', 'An error occurred: $e');
    }
  }

  void showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (title == 'Success') {
                  Navigator.of(context).pop(); // Close the previous dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showLeaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please select a reason for leaving:'),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: reasonSelected,
                items: reasons.map((String reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  reasonSelected = newValue;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                // Set dropdown color to orange
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // Set text color for the button
              ),
              onPressed: () {
                reasonSelected = null;
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange, // Set text color to white
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await leaveSociety();
              },
            ),
          ],
        );
      },
    );
  }
}
