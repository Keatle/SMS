import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/EventAttandanceScreen/components/event_attandance_body.dart';

class AttendanceRegister extends StatelessWidget {
  final String studentN ;

  AttendanceRegister({required this.studentN, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          // Background
          Container(
            height: double.infinity,
            width: double.infinity,
                  color: Color.fromARGB(255, 248, 122, 12),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 24),
              child: Text(
                'Attendance Register',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                 // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Content Area
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: AttendanceRegisterBody(studentN: studentN),
            ),
          ),
        ],
      ),
    );
  }
}
