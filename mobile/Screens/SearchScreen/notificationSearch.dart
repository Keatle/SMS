import 'package:flutter/material.dart';

class NotificationSearch extends StatefulWidget {
  final Function(String) onSearch;

  NotificationSearch({required this.onSearch});

  @override
  _NotificationSearchState createState() => _NotificationSearchState();
}

class _NotificationSearchState extends State<NotificationSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search notifications...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () => widget.onSearch(_searchController.text),
        ),
      ),
      onSubmitted: (value) => widget.onSearch(value),
    );
  }
}
