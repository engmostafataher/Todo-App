import 'package:flutter/material.dart';

class TextForms extends StatelessWidget {
  TextEditingController nameController;
  TextInputType keyboardText;
  String labelTexts;
  String? hintTexts;

   TextForms({super.key,required this.nameController,required this.keyboardText,required this.labelTexts,this.hintTexts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: TextFormField(
        controller: nameController,
        cursorColor: Colors.white,
        keyboardType: keyboardText,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
            labelText: labelTexts,
            labelStyle: TextStyle(color: Colors.white),
            hintText: hintTexts,
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}
