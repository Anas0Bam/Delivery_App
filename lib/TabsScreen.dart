import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mnadibapp/Login_screen/VeryfiAut.dart';
import 'package:mnadibapp/Model/globals.dart';
import 'package:mnadibapp/Screens/home-screen.dart';
import 'package:mnadibapp/Service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Screens/more.dart';

import 'Screens/cart.dart';
// import './ScreenPages/ProfilePage.dart';
// import './ScreenPages/cart.dart';
// import './ScreenPages/Favorite.dart';
// import './ScreenPages/Notificationsgae.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
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
    Navigator.of(context);
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      Sendverficiationme();
      timer = Timer.periodic(
        Duration(seconds: 3),
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

  Future Sendverficiationme() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 45));
      setState(() => canResendEmail = true);
    } catch (e) {
      if (e == 'Try again later.') {
        displayMessage('Please wait for 1 mint till you send back again');
      } else {
        displayMessage('Please wait for 1 min till you reset the message');
      }
    }
  }

  var lii = [
    const more(),
    // const Favorite(),

    HomeScreen(),
    const cart(),
  ];

  int d = 1;

  //SnackBarError Displayer
  // void snacl() {
  //   final tex = 'This page is under mIantance';
  //   final snac = SnackBar(
  //     duration: Duration(seconds: 1),
  //     content: Text(tex),
  //     backgroundColor: Colors.red,
  //   );
  //   ScaffoldMessenger.of(
  //     context,
  //   ).removeCurrentSnackBar();
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(snac);
  // }

  Widget build(BuildContext context) => isEmailVerified
      ? Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: lii[d],
          // body: Center(
          //   child: Text(
          //     jjj[d]['k'] as String,
          //   ),
          // ),
          bottomNavigationBar: CurvedNavigationBar(
              buttonBackgroundColor: Theme.of(context).primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              height: 60,
              backgroundColor: Theme.of(context).colorScheme.background,
              index: d,
              onTap: (ss) => setState(() => d = ss),
              items: [
                const Icon(Icons.more_horiz),
                // IconButton(
                //     icon: Icon(Icons.favorite_border), onPressed: snacl),
                Icon(
                  Icons.store_mall_directory_outlined,
                ),
                Icon(Icons.add_shopping_cart_sharp),

                // IconButton(
                //   icon: Icon(Icons.notifications_active_outlined),
                //   onPressed: snacl,
                // )
              ]),
        )
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
                      label: !canResendEmail
                          ? Text(
                              AppLocalizations.of(context)!.wait,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045),
                            )
                          : Text(
                              AppLocalizations.of(context)!.resend,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                      onPressed: canResendEmail ? Sendverficiationme : null,
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
