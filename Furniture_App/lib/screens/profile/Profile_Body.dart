import 'package:flutter/material.dart';
import 'package:project/screens/SignsScreen/Sign_Pages.dart';

import 'ProfileMenu.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody() : super();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            // Container(
            //  alignment: Alignment.center, // Center align
            Row(
              children: [
                SizedBox(width: (MediaQuery.of(context).size.width) / 3 + 15),
                Text('Profile',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff252B48))),
                SizedBox(width: 80),
                IconButton(
                  onPressed: () {},
                  icon: Icon(isDark ? Icons.sunny : Icons.bedtime),
                ),
              ],
            ),

            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assests/images/Profile.jpg"),
                  ),
                  Positioned(
                      right: -1,
                      bottom: -5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {},
                              color: Colors.grey,
                            )),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 40,child: Text("User name", style: TextStyle(
                fontSize: 25,
                fontFamily: "poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff252B48))),
            ),
            ProfileMenu(
              text: "My Account",
              icon: Icons.person,
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notifications,
              press: () {},
            ),
            ProfileMenu(
              text: "Language",
              icon: Icons.translate_rounded,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: Icons.help_outline,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return  Sign_Pages();
                }));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
