import 'package:flutter/material.dart';
import 'package:byte_blossoms/model/eventModel.dart';
import 'package:byte_blossoms/services/eventrsvp_service.dart';
import 'package:byte_blossoms/services/event_service.dart';

class EventRSVPBody extends StatefulWidget {
  final String studentN;

  EventRSVPBody({required this.studentN});

  @override
  _EventRSVPBodyState createState() => _EventRSVPBodyState();
}

class _EventRSVPBodyState extends State<EventRSVPBody> {
  List<Event> _events = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchRSVPEventsByStudentN();
  }

  Future<void> _fetchRSVPEventsByStudentN() async {
    try {
      final EventService eventService = EventService();
      final events = await eventService.fetchEventsByStudentN(widget.studentN);
      if (mounted) {
        setState(() {
          _events = events;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _confirmAttendance(int eventID) async {
    try {
      final EventRSVPService rsvpService = EventRSVPService();
      await rsvpService.confirmAttendance(eventID, widget.studentN);
      setState(() {
        _events.removeWhere((event) => event.eventID == eventID);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance confirmed')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to confirm attendance: $e')));
    }
  }

  Future<void> _rejectAttendance(int eventID) async {
    try {
      final EventRSVPService rsvpService = EventRSVPService();
      await rsvpService.rejectAttendance(eventID, widget.studentN);
      setState(() {
        _events.removeWhere((event) => event.eventID == eventID);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance rejected')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to reject attendance: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];

        return Card(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        event.eventName ?? 'No Title',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      event.societyName ?? 'No Society',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(event.eventDescription ?? 'No Description'),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Date: ${DateTime.parse(event.eventDate ?? '').day}/${DateTime.parse(event.eventDate ?? '').month}/${DateTime.parse(event.eventDate ?? '').year}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Time: ${DateTime.parse(event.eventDate ?? '').hour}:${DateTime.parse(event.eventDate ?? '').minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Venue: ${event.preferredVenue ?? 'No Venue'}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _rejectAttendance(event.eventID!),
                      child: Text(
                        'Decline',
                        style: TextStyle(color: Color.fromARGB(255, 248, 122, 12)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 205, 155),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _confirmAttendance(event.eventID!),
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 248, 122, 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
