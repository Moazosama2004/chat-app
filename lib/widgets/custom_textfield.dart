import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hintText, this.onChange, this.obscureText = false}) : super(key: key);

  final String hintText;
  final Function(String)? onChange;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data){
        if (data!.isEmpty) {
          return 'this data is required';
        }
      },
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
