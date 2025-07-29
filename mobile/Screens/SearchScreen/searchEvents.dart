import 'package:flutter/material.dart';
import 'package:byte_blossoms/model/eventModel.dart'; // Adjust the import according to your file structure
import 'package:byte_blossoms/services/searchEvent_service.dart'; // Adjust the import according to your file structure

class EventSearchPage extends StatefulWidget {
  @override
  _EventsSearchPageState createState() => _EventsSearchPageState();
}

class _EventsSearchPageState extends State<EventSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Event>>? _searchResults;
  final EventService _eventService = EventService();

  void _performSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = _eventService.searchEvents(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Events",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 122, 12),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),

              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Events...',
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),

                  filled: true,
                  fillColor: Color.fromARGB(251, 255, 255, 255),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Color.fromARGB(255, 248, 122, 12)),
                    onPressed: _performSearch,
                  ),

                ),

                onChanged: (value) {
                  setState(() {
                    _searchResults = _eventService.searchEvents(value);
                  });
                },
                
                onSubmitted: (value) => _performSearch(),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<Event>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No events found.'));
                  } else {
                    final events = snapshot.data!;
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        DateTime? eventDate;
                        try {
                          eventDate = DateTime.parse(event.eventDate ?? '');
                        } catch (e) {
                          eventDate = null; // Fallback if date parsing fails
                        }

                        return Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Spacer(),
                                    Text(
                                      event.societyName ?? 'No Society',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      eventDate != null
                                          ? '${eventDate.day}/${eventDate.month}/${eventDate.year}'
                                          : 'Invalid Date',
                                      style: const TextStyle(
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
                                        event.eventName ?? 'No Title',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    event.eventDescription ?? 'No Description',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    eventDate != null
                                        ? 'Date: ${eventDate.day}/${eventDate.month}/${eventDate.year}'
                                        : 'No Date',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 105, 105, 105),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    eventDate != null
                                        ? 'Time: ${eventDate.hour}:${eventDate.minute.toString().padLeft(2, '0')}'
                                        : 'No Time',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 105, 105, 105),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Venue: ${event.preferredVenue ?? 'No Venue'}',
                                    style: const TextStyle(
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
