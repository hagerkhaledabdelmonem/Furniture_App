import 'package:flutter/material.dart';

import '../SignsScreen/Sign_Pages.dart';



class Welcome_Page extends StatelessWidget {
  const Welcome_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        height: screenHeight,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          //opacity: 0.7,
          image: AssetImage("assests/images/Welcome_Page.jpg"),
        )),
      ),
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Make your home beautiful",
              style: TextStyle(fontSize: 35, fontFamily: "poppins",fontWeight: FontWeight.bold,),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "The best simple place where you discover most wonderful furnitures and make your home beautiful",
              style: TextStyle(fontSize: 20, fontFamily: "poppins",color: Colors.grey,height: 2),
            ),
            SizedBox(height: 200),
            ElevatedButton(
                child: Text(
                    "Get Started",
                    style: TextStyle(fontSize: 20)
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(28)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                        )
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sign_Pages()),
                  );
                }
            )
          ],
        ),
      ))
    ]));
  }
}
