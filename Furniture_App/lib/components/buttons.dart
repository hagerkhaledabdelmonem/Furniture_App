
import 'package:flutter/material.dart';

class button extends StatelessWidget {
   button({required this.text,this.onTap}) ;
  String? text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 300,
        height: 44,
        decoration: BoxDecoration(
            color: Color(0xff7C7C7E),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(text!,style: TextStyle(
          color: Colors.white,

        ),)),
      ),
    );
  }
}
