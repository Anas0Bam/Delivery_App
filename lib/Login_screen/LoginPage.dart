// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:mnadibapp/Service/auth.dart';
import 'package:mnadibapp/widgets/MyButton.dart';
import 'package:mnadibapp/widgets/Textfileddetials.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    if (context.mounted)
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
    var height = MediaQuery.of(context).size.height;
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
                    height: height * 0.250,
                  ),
                  Text(AppLocalizations.of(context)!.welcomeTitle),
                  SizedBox(height: 15),
                  MyTextfield(
                      pre: "",
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.emailAddress,
                      hintText: AppLocalizations.of(context)!.email,
                      //   selectIcon: null,
                      textController: emailcontroller,
                      obscureText: false),
                  SizedBox(
                    height: 15,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.visiblePassword,
                      //   selectIcon: Icon(Icons.password_outlined),
                      hintText: AppLocalizations.of(context)!.password,
                      textController: passwordcontroller,
                      obscureText: true),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          })),
                          child: Text(
                            AppLocalizations.of(context)!.forgotPass,
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
                    TextLable: AppLocalizations.of(context)!.login,
                    onTap: signUserIn,
                  ),
                  SizedBox(
                    height: height * 0.040,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.025),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.010),
                          child: Text(
                              AppLocalizations.of(context)!.ortextFirstPag),
                        ),
                        Expanded(
                          child: Divider(
                              thickness: 1, color: Colors.grey..shade500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.050,
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
                  SizedBox(
                    height: height * 0.050,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.notAmember,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        splashColor: Colors.white54,
                        onTap: widget.ontap,
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
