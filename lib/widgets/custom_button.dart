import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, this.ontap}) : super(key: key);

  final String text;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: Center(
          child: Text(
            text,style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
    );
  }
}
