import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ModalProgressHUD(
        inAsyncCall: false,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 100.0,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32, fontFamily: 'Pacifico', color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChange: (data){
                    email = data;
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChange: (data){
                    password = data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Login',
                  ontap: () async {
                    try {
                      await loginUser();
                      showSnackBar(context , message: 'Success',);
                      Navigator.pushNamed(context, ChatScreen.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context , message: 'No user found for that email.',);
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context , message: 'Wrong password provided for that user.',);
                      }
                    } catch(e) {
                      print(e.toString());
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account ? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Color(0xffb2d3c8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
     final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
  }
}
