import 'package:flutter/material.dart';

class JoinSociety extends StatefulWidget {
  const JoinSociety({Key? key}) : super(key: key);

  @override
  State<JoinSociety> createState() => _JoinSocietyState();
}

class _JoinSocietyState extends State<JoinSociety> {
  List<String> names = [
    "Campus Outreach",
    "ABASA",
    "Campus Impact",
    "Limitless Education & Skill Projects",
  ];

  List<String> designation = [
    "Christian Society",
    "ABASA",
    "Get-together Society",
    "Limitless Education & Skill Projects",
  ];

  List<String> descriptions = [
    'Description of Campus Outreach...',
    'Description of ABASA...',
    'Description of Campus Impact...',
    'Description of Limitless Education & Skill Projects...',
  ];

  List<String> emails = [
    'campus@outreach.com',
    'abasa@organization.com',
    'campusimpact@university.com',
    'LESP@gmail.com',
  ];

  List<String> phones = [
    '08000 55555',
    '08000 12345',
    '08000 67890',
    '12345 67890',
  ];

  List<String> images = [
    'assets/images/societies/society1.jpg',
    'assets/images/societies/society2.png',
    'assets/images/societies/society3.jpg',
    'assets/images/societies/society4.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text("Societies"),
        backgroundColor: Color.fromARGB(255, 248, 122, 12),

      ),


      body: ListView.builder(
        
        itemCount: 3,
        itemBuilder: (context, index) {

          return Padding(
            padding: EdgeInsets.all(8.0),

            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

                backgroundColor: Colors.white,
                collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),

              ),

              collapsedBackgroundColor: Colors.white,
              leading: CircleAvatar(
                backgroundImage: AssetImage(images[index]),
                radius: 30,
              ),

              title: Text(names[index]),
              subtitle: Text(designation[index]),
              children: [

                Card(
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                                                  CircleAvatar(
                                                    radius: 50.0,
                                                    backgroundImage: AssetImage(images[index]),
                                                  ),

                                                  SizedBox(height: 16.0),
                                                  Text(
                                                    names[index],
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey,
                                                    ),

                                                  ),

                                                  SizedBox(height: 16.0),
                                                  Text(
                                                    descriptions[index],
                                                    textAlign: TextAlign.center,
                                                  ),

                                                  SizedBox(height: 8.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.email),
                                                      SizedBox(width: 4.0),
                                                      Text(emails[index]),
                                                    ],
                                                  ),

                                                  SizedBox(height: 8.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.phone),
                                                      SizedBox(width: 4.0),
                                                      Text(phones[index]),
                                                    ],
                                                  ),

                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                         
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              
                              child: MaterialButton(
                                minWidth: 150,
                                height: 50,
                                color: const Color.fromARGB(255, 248, 122, 12),
                                elevation: 1,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: const Text(
                                  "Request to Join",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),

                              ),

                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
