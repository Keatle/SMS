import 'package:flutter/material.dart';
import 'package:byte_blossoms/model/meetingModel.dart';
import 'package:byte_blossoms/services/meeting_service.dart';

class ViewAgendasBody extends StatefulWidget {
  final String studentN;

  ViewAgendasBody({required this.studentN});

  @override
  _ViewAgendasBodyState createState() => _ViewAgendasBodyState();
}

class _ViewAgendasBodyState extends State<ViewAgendasBody> {
  List<AgendaData> _agendas = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAgendasByStudentN();
  }

  Future<void> _fetchAgendasByStudentN() async {
    try {
      final AgendaService agendaService = AgendaService();
      final agendas = await agendaService.getAgendasByStudentNumber(widget.studentN);
      if (mounted) {
        setState(() {
          _agendas = agendas;
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    return ListView.builder(
      itemCount: _agendas.length,
      itemBuilder: (context, index) {
        final agenda = _agendas[index];

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
                        agenda.meetingTitle ?? 'No Title',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${agenda.meetingDate.day}/${agenda.meetingDate.month}/${agenda.meetingDate.year}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    agenda.societyName ?? 'No Society',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    agenda.agenda ?? 'No Agenda Content',
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Date: ${agenda.meetingDate.day}/${agenda.meetingDate.month}/${agenda.meetingDate.year}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Time: ${agenda.meetingTime.hour}:${agenda.meetingTime.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Venue: ${agenda.venue ?? 'No Venue'}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
