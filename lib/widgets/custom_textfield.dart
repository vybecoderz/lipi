import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String hintText;
  IconData icon;
  String labelText;
  bool obscureText;
  TextInputType keyboardType;
  Function onChanged;
  String validateContent;

  CustomTextField({this.hintText, this.icon, this.labelText, this.obscureText, this.keyboardType, this.onChanged, this.validateContent});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: TextField(
              obscureText: obscureText,
              scrollPadding: EdgeInsets.all(10.0),
              keyboardType: keyboardType,
              onChanged: onChanged,
              decoration: InputDecoration(
                errorText: validateContent,
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: labelText,
              ),
            ),
          ),
        ],
      ),

    );
  }
}