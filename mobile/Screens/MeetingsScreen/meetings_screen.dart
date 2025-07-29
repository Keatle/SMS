import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/MeetingsScreen/components/meetings_screen_body.dart';

class ViewMeetings extends StatelessWidget {
  final String studentN;

  ViewMeetings({required this.studentN, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
       appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Meetings",
          style: TextStyle(
            color: Colors.white, // Set the title text color to white
          ),
        ),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
        iconTheme: IconThemeData(
          color: Colors.white, // Make the back arrow icon white
        ),
      ),
      body: Stack(
        children: [
          ViewAgendasBody(studentN: studentN),
        ],
      ),
    );
  }
}
