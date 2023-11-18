import 'package:flutter/material.dart';


class ProfileMenu extends StatelessWidget {
  ProfileMenu({required this.text, required this.icon, this.press});
  String? text;
  IconData icon;
  Color color=Color(0xff252B48);
  VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(icon,color:color,),
            SizedBox(width: 20),
            Expanded(child: Text(text!,style:TextStyle(color:color))),
            Icon(Icons.arrow_forward_ios,color: color,),
          ],
        ),
      ),
    );
  }
}