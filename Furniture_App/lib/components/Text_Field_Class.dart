import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  TextForm({required this.text, required this.icon,this.sicon,this.onChanged});
  String? text;
  IconData icon;
  IconData? sicon;
  Function(String)?onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (data){
          if(data!.isEmpty)
            return 'field is required';
        },

        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: Icon(sicon),
          hintText: text,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.grey)),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(40),
          //     borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
