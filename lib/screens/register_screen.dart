import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                Image.asset(
                  kLogo,
                ),
                Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 32, fontFamily: 'Pacifico', color: Colors.white),
                ),
                Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChange: (data) {
                    print(data);
                    email = data;
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChange: (data) {
                    print(data);
                    password = data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Register',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {

                        });
                        await registerUser();
                        showSnackBar(context, message: 'Success');
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context,
                              message: 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              message: 'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, message: 'There was an error');
                      }
                      isLoading = false;
                      setState(() {

                      });
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
                      'already have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Color(0xffb2d3c8)),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}


