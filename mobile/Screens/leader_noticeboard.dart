import 'package:flutter/material.dart';
import 'package:byte_blossoms/screens/join.dart';
import 'package:byte_blossoms/screens/joined.dart';
import 'package:byte_blossoms/screens/notifications.dart';
import 'package:byte_blossoms/screens/welcome.dart';

class LeaderNoticeboard extends StatelessWidget {
  var height, width;
  
  final String userID ;

  static const IconData rsvp = IconData(0xe545, fontFamily: 'MaterialIcons'); 

  LeaderNoticeboard({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    
    return Scaffold(

      // START OF DRAWER CODE
      drawer: Drawer(
        child: Container(
          //child: Your widget,
          color: const Color.fromARGB(255, 255, 255, 255),
          width: double.infinity,
          height: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            DrawerHeader(
              decoration: BoxDecoration(
                color:  Color.fromRGBO(245, 161, 25, 1),
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
                    'Samantha The leader',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Societies'),
              onTap: () {
                navigateToScreen(context, 0);
              },
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
                color:  Color.fromRGBO(245, 161, 25, 1),
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
                            "July 17 ",
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
                //top of the the body line 
                child: Container(

                  decoration: BoxDecoration(
                    
                    color: Color.fromARGB(255, 234, 234, 234),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),

                  ),
                 // child: ViewEventsBody(studentN: studentN),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JoinSociety()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JoinedSociety(userID: userID)),
        );
        break;
   
     
       
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage(userID : userID)),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
        break;
    
      default:
        
        break;
    }
  }  
}
