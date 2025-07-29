import 'package:flutter/material.dart';
import 'components/event_rsvp_body.dart';

class EventRSVP extends StatelessWidget {
    final String studentN;

  EventRSVP({required this.studentN, Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text("Upcoming Events"),
        backgroundColor:  Color.fromARGB(255, 248, 122, 12),
      ),
      body: Stack(
        children: [
          EventRSVPBody(studentN: studentN),
        ],
      ),
    );
  }
}

