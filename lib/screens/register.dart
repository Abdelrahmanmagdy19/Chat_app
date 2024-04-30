import 'package:chat_app/widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfild.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

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
                      'Register',
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
                SizedBox(height: 12),
                CustomButtom(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLodaing = true;
                      setState(() {});
                      try {
                        await refisterUser();
                        Navigator.pushNamed(context, 'ChatPgae',
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakbar(context, 'Weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakbar(context, 'email-already-in-use');
                        }
                      } catch (e) {
                        showSnakbar(context, 'there was an error');
                      }
                      isLodaing = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Register',
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an acount',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '  LOGIN',
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

  Future<void> refisterUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
