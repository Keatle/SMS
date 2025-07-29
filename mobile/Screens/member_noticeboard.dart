import 'package:byte_blossoms/Screens/pendingSocieties.dart';
import 'package:byte_blossoms/screens/colorProvider.dart';
import 'package:byte_blossoms/screens/pendingSocieties.dart';
import 'package:byte_blossoms/screens/profile.dart';
import 'package:byte_blossoms/screens/settingsPage.dart';
import 'package:byte_blossoms/services/userDash_service';
import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/joined.dart';
import 'package:byte_blossoms/screens/notifications.dart';
import 'package:byte_blossoms/screens/societyList.dart';
import 'package:byte_blossoms/screens/welcome.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Academic.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Culture.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Internationalisation.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Political.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Social.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Religious.dart';
import 'package:byte_blossoms/screens/EventAttandanceScreen/event_attandance.dart';
import 'package:byte_blossoms/screens/EventsScreen/events_screen.dart';
import 'package:byte_blossoms/screens/EventRSVPScreen/event_rsvp.dart';
import 'package:byte_blossoms/screens/CreatePasswordScreen/password_screen.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';



class DashboardStudent extends StatefulWidget {
  final String userID;
  final String studentN;

  const DashboardStudent({Key? key, required this.userID, required this.studentN}) : super(key: key);

  @override
  _DashboardStudentState createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> with SingleTickerProviderStateMixin {
  final UserService _userService = UserService();
  late TabController _tabController;

  //String currentDate = DateFormat('MMMM d').format(DateTime.now());
  bool isLoading = true;
  String userName = '';
  String userSurname = ''; 
  int unreadNotifications = 0; // Variable for holding the notification count

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchUserDetails();
    _fetchUnreadNotifications();
  }

  Future<void> _fetchUnreadNotifications() async {
    try {
      unreadNotifications = await _userService.fetchUnreadNotificationCount(widget.userID);
      setState(() {});
    } catch (error) {
      print('Error fetching unread notifications');
    }
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
    backgroundColor: Colors.grey[200], // Set the background color to white
    drawer: _buildDrawer(context),
    body: Builder(
      builder: (context) => Container(
        color: Colors.white, // Set background color to white
        child: Column(
          children: [
            _buildHeader(height, width, context),
            Material(
              color: Colors.white, // Ensure TabBar has a white background
              child: TabBar(
                controller: _tabController,
                labelColor: Color.fromARGB(255, 248, 122, 12), // Active tab text color
                unselectedLabelColor: Colors.grey, // Inactive tab text color
                indicatorColor: Color.fromARGB(255, 248, 122, 12), // Tab indicator color
                tabs: [
                  Tab(text: 'Notifications'),
                  Tab(text: 'Events'),
                  Tab(text: 'Pending Societies'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  NotificationsPage(userID: widget.userID),
                  ViewEvents(studentN: widget.studentN),
                  PendingSocieties(userID: widget.userID),
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
    final colorProvider = Provider.of<ColorProvider>(context); // Access the ColorProvider
    String currentDate = DateFormat('MMMM d').format(DateTime.now()); // Format current date

    return Container(
      color: colorProvider.headerColor, // Use the header color from the provider
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
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                badges.Badge(
                  badgeContent: Text(
                    unreadNotifications.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Add notification logic here
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Dashboard',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              currentDate,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            )
          ),
        ],
      ),
    );
  }



Widget _buildDrawer(BuildContext context) {
  final colorProvider = Provider.of<ColorProvider>(context); // Access the ColorProvider
  
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
              color: colorProvider.headerColor, // Use dynamic header color from the provider
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
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
          leading: Icon(Icons.group),
          title: Text('Registered Societies'),
          onTap: () {
            navigateToScreen(context, 0);
          },
        ),
       // ExpansionTile(
       ////   leading: Icon(Icons.category_rounded),
       ////   title: Text('Departments'),
       //   children: _buildDepartmentTiles(),
       // ),
        ListTile(
          leading: Icon(Icons.check_box_outlined),
          title: Text('Joined Societies'),
          onTap: () {
            navigateToScreen(context, 1);
          },
        ),
        /* ListTile(
          leading: Icon(Icons.how_to_vote),
          title: Text('Profile'),
          onTap: () {
            navigateToScreen(context, 2);
          },
        ),*/
       ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Settings'),
          onTap: () {
           navigateToScreen(context, 4);
         },
        ),
       // ListTile(
          //leading: Icon(Icons.event),
        //  title: Text('Upcoming Events'),
         // onTap: () {
         //   navigateToScreen(context, 3);
       ///   },
      //  ),
        ListTile(
          leading: Icon(Icons.rsvp),
          title: Text('Event RSVP'),
          onTap: () {
            navigateToScreen(context, 9);
          },
        ),
        ListTile(
          leading: Icon(Icons.content_paste_sharp),
          title: Text('Attendance Register'),
          onTap: () {
            navigateToScreen(context, 7);
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
          MaterialPageRoute(builder: (context) =>SocietyListPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  JoinedSociety(userID: widget.userID)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(userID : widget.userID, studentN: widget.studentN)),
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
          MaterialPageRoute(builder: (context) => SettingsPage()),
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
          MaterialPageRoute(builder: (context) => ChangePasswordScreen(userID: widget.userID, studentN :widget.studentN)),
        );
        break;

      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceRegister(studentN: widget.studentN)),
        );
        break;
        
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventRSVP(studentN: widget.studentN)),
        );
        break;
        
      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CultureSocietiesList()),
        );
        break;

      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InternationalisationSocietiesList()),
        );
        break;

      case 12:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliticalSocietiesList()),
        );
        break;

      case 13:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReligiousSocietiesList()),
        );
        break;

      case 14:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SocialSocietyList()),
        );
        break;
      case 15:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcademicSocietiesList()),
        );
        break;


      default:
        // Handle default case if needed
        break;
    }
  }
}
