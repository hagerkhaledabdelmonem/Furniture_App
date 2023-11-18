import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/components/buttons.dart';

import '../../Home/Home.dart';
import '../../components/Text_Field_Class.dart';
import '../../lists/List_users.dart';
import 'Sign_In.dart';
import 'Sign_Pages.dart';



class Sign_Up extends StatefulWidget{
  _SignUpState createState()=> _SignUpState();
}

class _SignUpState extends State<Sign_Up>{
  bool isFemale=true;
  bool isloading = false;
  String? email, password;
  String? userName;
  int couter=0;
  bool isSignupScreen = true;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextForm(text: "User Name", icon: Icons.person
            ),
            TextForm(text: "Email", icon: Icons.email_outlined,onChanged: (data){
              email=data;
              Users[couter]=data.toString();
            }
            ),
            TextForm(text: "Password", icon: Icons.lock_rounded,onChanged: (data){
              password=data;
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFemale = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isFemale ? Colors.transparent : Colors.grey,
                            border: Border.all(
                              width: 1,
                              color: isFemale ? Colors.grey : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isFemale ? Colors.grey : Colors.white,
                          ),
                        ),
                        Text(
                          "Male",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFemale = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isFemale ? Colors.grey : Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: isFemale ? Colors.transparent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isFemale ? Colors.white : Colors.grey,
                          ),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            button(text: 'Sign Up',
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  isloading = true;
                  setState(() {});
                  try {
                    var auth = FirebaseAuth.instance;
                    UserCredential user =
                    await auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Mail Created Successfuly')));

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return  HomePage(mail: FirebaseAuth.instance.currentUser?.email);
                    }));


                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Week Password')));
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'The account already exists for that email')));
                    }
                  }
                  isloading = false;
                  setState(() {});
                }
              },),
          ],
        ),
      ),
    );
  }
}
