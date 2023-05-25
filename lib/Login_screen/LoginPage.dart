// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import '../Compoentes/Textfileddetials.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Compoentes/MyButton.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  final Function()? ontap;
  const LoginPage({super.key, required this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        displayMessage(
            'It seems that you are not register yet, please go ahead and register.');
      } else if (e.code == 'wrong-password') {
        displayMessage('Incorrect password');
      } else if (e.code == 'unknown') {
        displayMessage('Enter your information');
      }
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
              child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/12.png',
                    height: 250,
                  ),
                  Text('Welcome to Manadib'),
                  SizedBox(height: 15),
                  MyTextfield(
                      inputTypedis: TextInputType.emailAddress,
                      hintText: 'email',
                      //   selectIcon: null,
                      textController: emailcontroller,
                      obscureText: false),
                  SizedBox(
                    height: 15,
                  ),
                  MyTextfield(
                      inputTypedis: TextInputType.visiblePassword,
                      //   selectIcon: Icon(Icons.password_outlined),
                      hintText: 'password',
                      textController: passwordcontroller,
                      obscureText: true),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          })),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(
                    TextLable: 'Sign in',
                    onTap: signUserIn,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('Or Continue with'),
                        ),
                        Expanded(
                          child: Divider(
                              thickness: 1, color: Colors.grey..shade500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     SquareTile(imagePath: 'assets/google.png'),
                  //     SizedBox(
                  //       width: 25,
                  //     ),
                  //     SquareTile(imagePath: 'assets/apple.png'),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        splashColor: Colors.white54,
                        onTap: widget.ontap,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
