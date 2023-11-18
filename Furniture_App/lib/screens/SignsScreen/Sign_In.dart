import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Home/Home.dart';
import '../../components/Text_Field_Class.dart';
import '../../components/buttons.dart';
import '../Transission.dart';



class Sign_In extends StatefulWidget{
  _SignInState createState()=> _SignInState();
}

class _SignInState extends State<Sign_In>{
  bool isrememberMe = false;
  bool isloading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 25),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextForm(text: "Email", icon: Icons.email_outlined,onChanged: (data){
              email=data;
            }, ),
            TextForm(text: "Password", icon: Icons.lock_rounded,onChanged: (data){
              password=data;
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: isrememberMe,
                        activeColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            isrememberMe = !isrememberMe;
                          });
                        }),
                    Text(
                      "Remember me",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            button(text: 'SignIn',onTap: ()async{
              if(formKey.currentState!.validate()){
                isloading=true;
                setState(() {

                });
                try{
                  UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successfuly')));
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return  HomePage(mail: FirebaseAuth.instance.currentUser?.email);
                  }));
                }
                on FirebaseAuthException catch(e){
                  if(e.code== 'wrong-password'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password provided for that user.')));
                  }else if(e.code == 'user-not-found'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email.')));
                  }

                }
                isloading=false;
                setState(() {

                });
              }

            },)
          ],
        ),
      ),
    );
  }
}
