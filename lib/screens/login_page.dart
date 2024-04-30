import 'package:chat_app/widgets/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  bool isLodaing = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLodaing,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  klogo,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      liveChat,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomformTextFiled(
                  onChanged: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                const SizedBox(height: 12),
                CustomformTextFiled(
                  onChanged: (data) {
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                const SizedBox(height: 12),
                CustomButtom(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLodaing = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, 'ChatPgae',
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakbar(context, 'user-not-found');
                        } else if (e.code == 'wrong-password') {
                          showSnakbar(context, 'wrong-password');
                        }
                      } catch (e) {
                        showSnakbar(context, 'there was an error');
                      }
                      isLodaing = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an acount',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
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
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
