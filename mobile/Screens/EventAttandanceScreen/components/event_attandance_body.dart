import 'package:flutter/material.dart';
import 'package:byte_blossoms/services/eventattendance_service.dart';

class AttendanceRegisterBody extends StatefulWidget {
  final String studentN;

  AttendanceRegisterBody({required this.studentN, Key? key}) : super(key: key);

  @override
  _AttendanceRegisterState createState() => _AttendanceRegisterState();
}

class _AttendanceRegisterState extends State<AttendanceRegisterBody> {
  final TextEditingController _codeController = TextEditingController();
  String _feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 244, 244),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Enter Attendance Code',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitAttendanceCode,
                child: Text(
                  'Submit',
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 139, 43),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _feedbackMessage,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

 void _submitAttendanceCode() async {
 String attendanceCode = _codeController.text.trim();
    
    if (attendanceCode.isEmpty) {
      setState(() {
        _feedbackMessage = 'Please enter a valid code';
      });
      return;
    }

    // Verify the attendance code
    final verifyResponse = await AttendanceService.verifyAttendanceCode(attendanceCode);

    if (verifyResponse != null && verifyResponse.containsKey('eventID')) {
      int eventID = verifyResponse['eventID'];
      String studentN = widget.studentN; // assuming studentN is passed via widget

      // Record the attendance
      bool recordSuccess = await AttendanceService.recordAttendance(eventID, studentN, attendanceCode);

      setState(() {
        _feedbackMessage = recordSuccess
            ? 'Attendance recorded successfully'
            : 'Failed to record attendance';
      });
    } else {
      setState(() {
        _feedbackMessage = 'Code entered is invalid';
      });
    }
  }

}
