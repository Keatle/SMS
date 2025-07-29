import 'package:byte_blossoms/screens/BudgetScreen/budgetScreen.dart';
import 'package:byte_blossoms/screens/MeetingsScreen/meetings_screen.dart';
import 'package:byte_blossoms/screens/MinutesScreen/components/minutes_screen_body.dart';
import 'package:byte_blossoms/screens/MinutesScreen/minutes_screen.dart';
import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/joined.dart';
import 'package:byte_blossoms/screens/notifications.dart';
import 'package:byte_blossoms/screens/welcome.dart';
import 'package:byte_blossoms/screens/EventsScreen/events_screen.dart';
import 'package:byte_blossoms/screens/CreatePasswordScreen/password_screen.dart';
import 'package:byte_blossoms/services/userDash_service.dart';
import 'package:intl/intl.dart';
import '../MeetingsScreen/components/meetings_screen_body.dart';

class DashboardChairperson extends StatefulWidget {
  final String userID;
  final String studentN;

  DashboardChairperson({Key? key, required this.userID, required this.studentN}) : super(key: key);

  @override
  _DashboardChairpersonState createState() => _DashboardChairpersonState();
}

class _DashboardChairpersonState extends State<DashboardChairperson> with SingleTickerProviderStateMixin {
  final UserService _userService = UserService();
  late TabController _tabController;

  String currentDate = DateFormat('MMMM d').format(DateTime.now());
  bool isLoading = true;
  String userName = '';
  String userSurname = ''; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final String? fullName = await _userService.fetchUserDetails(widget.userID);

      if (fullName != null) {
        setState(() {
          final nameParts = fullName.split(' ');
          userName = nameParts[0];
          userSurname = nameParts.length > 1 ? nameParts[1] : '';
        });
      } else {
        setState(() {
          userName = 'No Name';
          userSurname = 'No Surname';
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        userName = 'Error';
        userSurname = 'Error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;

  return Scaffold(
    drawer: _buildDrawer(),
    body: Builder(
      builder: (context) => Container(
        color: Colors.white, // Set background color to white
        child: Column(
          children: [
            _buildHeader(height, width, context),
            TabBar(
              controller: _tabController,
              labelColor: Color.fromARGB(255, 248, 122, 12),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color.fromARGB(255, 248, 122, 12),
              tabs: [
                Tab(text: 'Mettings'),
                Tab(text: 'Minutes'),
                Tab(text: 'Status')
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ViewAgendasBody(studentN: widget.studentN),
                  ViewMinutesBody(studentN: widget.studentN),
                  ViewBudgetsBody(userID: widget.userID),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildHeader(double height, double width, BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 248, 122, 12),
      height: height * 0.25,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Noticeboard",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  currentDate,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 122, 12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '$userName $userSurname',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerList() {
    return Column(
      children: [
            ListTile(
              leading: Icon(Icons.check_box_outlined),
              title: Text('Joined Societies'),
              onTap: () {
                navigateToScreen(context, 1);
              },
            ),

            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text('Change Password'),
              onTap: () {
                navigateToScreen(context, 6);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                navigateToScreen(context, 5);
              },
            ),
      ],
    );
  }

  List<Widget> _buildDepartmentTiles() {
    return [
      ListTile(
        title: Text('Religious'),
        onTap: () {
          navigateToScreen(context, 13);
        },
      ),
      ListTile(
        title: Text('Academic'),
        onTap: () {
          navigateToScreen(context, 15);
        },
      ),
      ListTile(
        title: Text('Internationalisation'),
        onTap: () {
          navigateToScreen(context, 11);
        },
      ),
      ListTile(
        title: Text('Social'),
        onTap: () {
          navigateToScreen(context, 14);
        },
      ),
      ListTile(
        title: Text('Political'),
        onTap: () {
          navigateToScreen(context, 12);
        },
      ),
      ListTile(
        title: Text('Culture'),
        onTap: () {
          navigateToScreen(context, 10);
        },
      ),
    ];
  }

  void navigateToScreen(BuildContext context, int index) {
     switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewBudgetsBody(userID: widget.userID)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JoinedSociety(userID: widget.userID, studentN:widget.studentN)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewMeetings(studentN: widget.studentN)),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewEvents(studentN: widget.studentN)),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage(userID : widget.userID)),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangePasswordScreen(userID: widget.userID, studentN: widget.studentN)),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewMinutes(studentN: widget.studentN)),
        );
        break;
 

      default:
    }
  }  
}
