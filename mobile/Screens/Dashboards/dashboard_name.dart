import 'package:byte_blossoms/screens/DepartmentScreen/Internationalisation.dart';
import 'package:byte_blossoms/screens/EventRSVPScreen/event_rsvp.dart';
import 'package:byte_blossoms/screens/MeetingsScreen/meetings_screen.dart';
import 'package:byte_blossoms/screens/MinutesScreen/minutes_screen.dart';
import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/join.dart';
import 'package:byte_blossoms/screens/registerSociety.dart';
import 'package:byte_blossoms/screens/joined.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Academic.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Culture.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Political.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Social.dart';
import 'package:byte_blossoms/screens/DepartmentScreen/Religious.dart';
import 'package:byte_blossoms/screens/notifications.dart';
import 'package:byte_blossoms/screens/EventsScreen/components/events_screen_body.dart';
import 'package:byte_blossoms/screens/welcome.dart';
import 'package:byte_blossoms/screens/EventsScreen/events_screen.dart';
import 'package:byte_blossoms/screens/CreatePasswordScreen/password_screen.dart';
import 'package:byte_blossoms/screens/EventAttandanceScreen/event_attandance.dart';

class SecretaryNoticeboard extends StatefulWidget {
  final String userID;
  final String studentN;

  SecretaryNoticeboard({Key? key, required this.userID, required this.studentN}) : super(key: key);

  @override
  _SecretaryNoticeboardState createState() => _SecretaryNoticeboardState();
}

class _SecretaryNoticeboardState extends State<SecretaryNoticeboard> {
  int _selectedIndex = 0;

  late double height;
  late double width;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic for each index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewMeetings(studentN: widget.studentN)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewMeetings(studentN: widget.studentN)),
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
          MaterialPageRoute(builder: (context) => ViewMeetings(studentN: widget.studentN)),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewMeetings(studentN: widget.studentN)),
        );
        break;
      // Add more cases as needed
    }
  }

    void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterSocietyPage()),
        );
        break;
       case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  JoinedSociety(userID: widget.userID, studentN:widget.studentN)),
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
      case 8:
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
    }
  }  

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      // START OF DRAWER CODE
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 230, 79, 79),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 122, 12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/woman.jpg"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Samantha The Leader',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.app_registration_rounded),
                title: Text('Register a society'),
                onTap: () {
                  navigateToScreen(context, 0);
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.category_rounded),
                title: Text('Departments'),
                children: <Widget>[
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
                ],
              ),
              ListTile(
                leading: Icon(Icons.check_box_outlined),
                title: Text('Joined Societies'),
                onTap: () {
                  navigateToScreen(context, 1);
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {
                  navigateToScreen(context, 4);
                },
              ),
              ListTile(
                leading: Icon(Icons.co_present_rounded),
                title: Text('Upcoming Meetings'),
                onTap: () {
                  navigateToScreen(context, 2);
                },
              ),
              ListTile(
                leading: Icon(Icons.punch_clock),
                title: Text('Recent Minutes'),
                onTap: () {
                  navigateToScreen(context, 7);
                },
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text('Upcoming Events'),
                onTap: () {
                  navigateToScreen(context, 3);
                },
              ),
              ListTile(
                leading: Icon(Icons.rsvp),
                title: Text('Upcoming Events'),
                onTap: () {
                  navigateToScreen(context, 9);
                },
              ),
              ListTile(
                leading: Icon(Icons.content_paste_sharp),
                title: Text('Attendance Register'),
                onTap: () {
                  navigateToScreen(context, 8);
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
          ),
        ),
      ),
      // END OF DRAWER CODE

      body: Builder(
        builder: (context) => Container(
          color: const Color.fromARGB(255, 248, 122, 12),
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
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
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Noticeboard",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "July 17",
                            style: TextStyle(
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
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 234, 234, 234),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ViewEventsBody(studentN: widget.studentN),
                ),
              ),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}




























