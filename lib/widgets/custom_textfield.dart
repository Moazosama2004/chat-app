import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hintText, this.onChange}) : super(key: key);

  final String hintText;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )),
      ),
    );
  }
}
