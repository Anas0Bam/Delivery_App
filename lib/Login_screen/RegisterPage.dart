// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_app/widgets/MyButton.dart';
import 'package:deliver_app/widgets/Textfileddetials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../Compoentes/square_tile.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  final _confirmPasswordTextController = TextEditingController();

  final _FirstName = TextEditingController();
  final _lastName = TextEditingController();
  final _Phonenumber = TextEditingController();
  final _Address = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      if (_passwordcontroller.text == _confirmPasswordTextController.text &&
          _Phonenumber.text.isNotEmpty &&
          _Address.text.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text,
        );
        // Navigator.pop(context);
        Navigator.pop(context);

        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'First Name': _FirstName.text.trim(),
          'Last Name': _lastName.text.trim(),
          'Address': _Address.text.trim(),
          'Phone Number': '+966 ' + _Phonenumber.text.trim(),
          'Email': _emailcontroller.text.trim()
        });
      } else if (_passwordcontroller.text !=
          _confirmPasswordTextController.text) {
        Navigator.pop(context);
        // Navigator.pop(context);
        displayMessage('Password does not match');
      } else if (_Phonenumber.text.isEmpty) {
        Navigator.pop(context);
        displayMessage('Enter the rest of the information');
      } else if (_Address.text.isEmpty) {
        Navigator.pop(context);
        displayMessage('Enter the rest of the information');
      }
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'unknown') {
      Navigator.pop(context);
      if (_emailcontroller.text.isEmpty &&
          _passwordcontroller.text.isEmpty &&
          _confirmPasswordTextController.text.isEmpty &&
          _Phonenumber.text.isEmpty &&
          _Address.text.isEmpty) {
        displayMessage('Please fill up your information');
      } else if (e.code == 'invaild-email') {
        displayMessage(e.code);
      } else if (_passwordcontroller.text.isEmpty ||
          _confirmPasswordTextController.text.isEmpty) {
        displayMessage('Please fill up both of your password fields');
      } else if (_emailcontroller.text.isEmpty) {
        displayMessage('Fill up your email');
      } else if (e.code == 'weak-password') {
        displayMessage('Please streanth your password');
      } else if (_passwordcontroller.text !=
          _confirmPasswordTextController.text) {
        displayMessage('Password does not match');
      } else if (e.code == 'email-already-in-use') {
        displayMessage('There is an account under this email');
      } else {
        displayMessage(e.code);
      }

      // }
    }
  }

//  if (e.code == 'unknown') {
//         displayMessage('missing: ${emailcontroller.value}');
//       }
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                message,
                style: TextStyle(color: Colors.red),
              ),
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmPasswordTextController.dispose();
    _FirstName.dispose();
    _lastName.dispose();
    _Phonenumber.dispose();
    super.dispose();
  }

  @override
  // TODO: implement widget

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
                    height: height * 0.26,
                  ),
                  Text(
                    AppLocalizations.of(context)!.lets,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: height * 0.015),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.name,
                      hintText: AppLocalizations.of(context)!.firstNa,
                      //   selectIcon: null,
                      textController: _FirstName,
                      obscureText: false),
                  SizedBox(
                    height: 15,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.name,
                      hintText: AppLocalizations.of(context)!.lastNa,
                      //   selectIcon: null,
                      textController: _lastName,
                      obscureText: false),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.emailAddress,
                      hintText: AppLocalizations.of(context)!.email,
                      //   selectIcon: null,
                      textController: _emailcontroller,
                      obscureText: false),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.visiblePassword,
                      //   selectIcon: Icon(Icons.password_outlined),
                      hintText: AppLocalizations.of(context)!.password,
                      textController: _passwordcontroller,
                      obscureText: true),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.visiblePassword,
                      //   selectIcon: Icon(Icons.password_outlined),
                      hintText: AppLocalizations.of(context)!.passwordconf,
                      textController: _confirmPasswordTextController,
                      obscureText: true),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextfield(
                      pre: '+966',
                      df: FilteringTextInputFormatter.digitsOnly,
                      inputTypedis: TextInputType.number,
                      hintText: AppLocalizations.of(context)!.phonenum,
                      //   selectIcon: null,
                      textController: _Phonenumber,
                      obscureText: false),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextfield(
                      pre: '',
                      df: FilteringTextInputFormatter.deny(''),
                      inputTypedis: TextInputType.streetAddress,
                      hintText: AppLocalizations.of(context)!.adress,
                      //   selectIcon: null,
                      textController: _Address,
                      obscureText: false),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  MyButton(
                    TextLable: AppLocalizations.of(context)!.register,
                    onTap: signUp,
                  ),
                  SizedBox(
                    height: height * 0.030,
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
                    height: height * 0.030,
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
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.030),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.already),
                        InkWell(
                          splashColor: Colors.white54,
                          onTap: widget.ontap,
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
