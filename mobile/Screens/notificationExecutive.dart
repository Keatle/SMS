import 'package:byte_blossoms/screens/fontSizeProvider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:byte_blossoms/model/notificationModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class TokenStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: 'auth_token');
  }
}

class NotificationsPage extends StatefulWidget {
  final String userID;

  const NotificationsPage({super.key, required this.userID});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<NotificationModel>> futureNotifications;
final String baseUrl = 'http/localhost:3006/';
  List<NotificationModel> _allNotifications = [];
  List<NotificationModel> _filteredNotifications = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';
  int unreadCount = 0;
  double selectedFontSizeOption = 16.0; // Define it as part of the state

  @override
  void initState() {
    super.initState();
    futureNotifications = fetchNotifications(widget.userID);
    _loadUnreadCount();
    _loadFontSize();  // Fetch font size on page load
  }

  void _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedFontSizeOption = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  Future<void> _loadUnreadCount() async {
    try {
      final count = await fetchUnreadCount(widget.userID);
      setState(() {
        unreadCount = count;
      });
    } catch (e) {
      print('Error loading unread count: $e');
    }
  }

  Future<List<NotificationModel>> fetchNotifications(String userID) async {
    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      final response = await http.get(Uri.parse('$baseUrl/notifications/$userID/Executives'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<NotificationModel> notifications = body
            .map((dynamic item) => NotificationModel.fromJson(item))
            .toList();
        setState(() {
          _allNotifications = notifications;
          _filteredNotifications = notifications;
          _isLoading = false;
        });
        return notifications;
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      throw Exception('Failed to load notifications: $e');
    }
  }

  double getFontSize(String fontSizeOption, double smallSize) {
    switch (fontSizeOption) {
      case 'small':
        return smallSize;
      case 'medium':
        return smallSize + 2;
      case 'large':
        return smallSize + 4;
      default:
        return smallSize; // Fallback to small if no valid option is provided
    }
  }

  Future<int> fetchUnreadCount(String userID) async {
    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      final response = await http.get(Uri.parse('$baseUrl/notifications/unreadCount/$userID'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['unreadCount'] as int;
      } else {
        throw Exception('Failed to load unread count');
      }
    } catch (e) {
      print('Error fetching unread count: $e');
      throw Exception('Failed to fetch unread count: $e');
    }
  }

  void _searchNotifications(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredNotifications = _allNotifications;
      });
    } else {
      setState(() {
        _filteredNotifications = _allNotifications
            .where((notification) =>
                notification.societyName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search notifications',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (query) {
        _searchNotifications(query);
      },
    );
  }

  void _markAsRead(NotificationModel notification) async {
    try {
      var token = await TokenStorage.readToken();
      if (token == null) {
        throw Exception('No authorization token found.');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/readNotifications/${notification.noticeID}'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          notification.isRead = true;
          if (unreadCount > 0) {
            unreadCount--; // Decrement the unread count
          }
        });
      } else {
        print('Failed to update notification status. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error marking notification as read: $error');
    }
  }

@override
Widget build(BuildContext context) {
  final fontSizeProvider = Provider.of<FontSizeProvider>(context); // Access the provider here

  return Scaffold(
    backgroundColor: Colors.grey[200],
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notification = _filteredNotifications[index];
                          DateTime? createdAtDate;
                          try {
                            createdAtDate = DateTime.parse(notification.createdAt);
                          } catch (e) {
                            createdAtDate = null;
                          }

                          return GestureDetector(
                            onTap: () => _markAsRead(notification),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0), // Set rounded corners
                              ),
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              color: Colors.white, // Set background color of the card
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            notification.societyName,
                                            style: TextStyle(
                                              fontSize: fontSizeProvider.fontSize, // Use provider font size
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          createdAtDate != null
                                              ? '${createdAtDate.day}/${createdAtDate.month}/${createdAtDate.year}'
                                              : 'Invalid Date',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: fontSizeProvider.fontSize - 2, // Adjust as necessary
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: notification.isRead ? Colors.grey : Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      notification.content,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: fontSizeProvider.fontSize - 2, // Adjust as necessary
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
  );
}
}