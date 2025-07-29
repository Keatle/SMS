import 'package:flutter/material.dart';
import 'package:byte_blossoms/model/leader_noticeboardModel.dart';
import 'package:byte_blossoms/services/leader_noticeboard_service.dart';

class LeaderNoticeboard extends StatefulWidget {
  final String userID;

  LeaderNoticeboard({required this.userID});

  @override
  _LeaderNoticeboardState createState() => _LeaderNoticeboardState();
}

class _LeaderNoticeboardState extends State<LeaderNoticeboard> {
  late NoticeboardService _serviceController;
  List<NoticeboardItem> _items = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _serviceController = NoticeboardService();
    _fetchNoticeboardItems();
  }

  Future<void> _fetchNoticeboardItems() async {
    int _userID = int.parse(widget.userID);

    try {
      final items = await _serviceController.fetchNoticeboardItems(_userID); // Fetch noticeboard items

      setState(() {
        if (items.isEmpty) {
          _errorMessage = 'No noticeboard updates available';
        } else {
          _items = items;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching noticeboard items: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235), 
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];

                    
                    DateTime? createdAt = item.createdAt;
                    DateTime? eventDate = item.eventDate;

                    return Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  item.societyName ?? 'No Society',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  createdAt != null
                                      ? '${createdAt.day}/${createdAt.month}/${createdAt.year}'
                                      : 'Invalid Date',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item.eventName ?? item.meetingTitle ?? item.type,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                item.eventDescription ?? item.agenda ?? 'No Description',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                eventDate != null
                                    ? 'Event Date: ${eventDate.day}/${eventDate.month}/${eventDate.year}'
                                    : 'No Event Date',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Time: ${item.meetingTime?.hour ?? 'No'}:${item.meetingTime?.minute.toString().padLeft(2, '0') ?? ''}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Venue: ${item.venue ?? 'No Venue'}',
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
                ),
    );
  }
}
