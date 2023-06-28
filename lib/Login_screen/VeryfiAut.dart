import 'dart:async';
import 'package:mnadibapp/TabsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmailPageState extends StatefulWidget {
  @override
  State<VerifyEmailPageState> createState() => _VerifyEmailPageStateState();
}

class _VerifyEmailPageStateState extends State<VerifyEmailPageState> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 5),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      if (e == 'Try again later.') {
        displayMessage('Please wait for 1 mint till you send back again');
      } else {
        displayMessage('Please wait for 1 min till you reset the message');
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? TabsScreen()
      : Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.verfi +
                          "${FirebaseAuth.instance.currentUser!.email}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(9))),
                      icon: Icon(
                        Icons.email,
                        size: 25,
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.resend,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red.shade700)),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: Text(AppLocalizations.of(context)!.cancel))
                  ]),
            ),
          ),
        );
}
