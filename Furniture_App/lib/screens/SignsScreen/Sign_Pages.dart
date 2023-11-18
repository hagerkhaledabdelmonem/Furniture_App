import 'package:flutter/material.dart';
import 'Sign_Up.dart';
import 'Sign_In.dart';


class Sign_Pages extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign_Pages> {
  bool isFemale = true;
  bool isSignupScreen = true;
  bool isrememberMe = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              //height: screenHeight,
              //height: 500,
              //Lottie.asset("assests/animation_llwurr6z.json"),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      //opacity: 0.8,
                      image: AssetImage("assests/images/background3.png"),
                      fit: BoxFit.fill
                  )
              ),
            )),
        Positioned(
          left: 30,
          width: 80,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assests/images/clock.png')
                )
            ),
          ),
        ),
        // Main Container for Signup & SignIn
        AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.bounceInOut,
            top: 300,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 450 : 380,
              padding: EdgeInsets.all(20),
              width: screenwidth - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ]),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNIN",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Colors.grey
                                        : Color(0XFF09126C)),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 4,
                                  width: 60,
                                  color: Colors.black,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Color(0XFF09126C)
                                        : Colors.grey),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 4,
                                  width: 60,
                                  color: Colors.black,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignupScreen)
                      Sign_Up()
                    else
                      Sign_In()
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
