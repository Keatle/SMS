import 'package:byte_blossoms/model/minutesModel.dart';
import 'package:byte_blossoms/services/searchMinutes_service.dart';
import 'package:flutter/material.dart';

class MinutesSearchPage extends StatefulWidget {
  @override
  _MinutesSearchPageState createState() => _MinutesSearchPageState();
}

class _MinutesSearchPageState extends State<MinutesSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<MinutesModel>>? _searchResults;
  final MinutesService _minutesService = MinutesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Minutes",
          style: TextStyle(
            color: Colors.white, // Set the title text color to white
          ),
        ),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),
        iconTheme: IconThemeData(
          color: Colors.white, // Make the back arrow icon white
        ),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Minutes...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(87, 248, 122, 12),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: _performSearch,
                  ),
                ),
                onSubmitted: (value) => _performSearch(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = _minutesService.searchMinutes(query);
      });
    }
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<MinutesModel>>(
      future: _searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No minutes found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final minute = snapshot.data![index];
              return _buildMinutesCard(minute);
            },
          );
        }
      },
    );
  }

  Widget _buildMinutesCard(MinutesModel minute) {
    return Card(
      color: Color.fromARGB(255, 255, 253, 251), // Cream-colored card background
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              minute.societyName ?? 'Unknown Society',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              minute.meetingTitle ?? 'Untitled Meeting',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Date: ${minute.meetingDate != null ? minute.meetingDate! : 'Unknown Date'}',
              style: TextStyle(
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Venue: ${minute.Venue ?? 'Unknown Venue'}',
              style: TextStyle(
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Minutes:',
              style: TextStyle(
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(minute.minutes ?? 'No Minutes Content'),
          ],
        ),
      ),
    );
  }
}
