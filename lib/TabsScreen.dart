// ignore: file_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import './ScreenPages/more.dart';

// import './ScreenPages/ProfilePage.dart';
import 'package:flutter/material.dart';
import './ScreenPages/cart.dart';
import './ScreenPages/Favorite.dart';
import './ScreenPages/Notificationsgae.dart';
import './ScreenPages/store.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool isEmailVerified = false;
  Timer? timer;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
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

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      displayMessage(e.toString());
    }
  }

  var lii = [
    const more(),
    const Favorite(),
    const store(),
    const cart(),
    const Notificationpage(),
  ];
  final icons = [
    const Icon(Icons.more_horiz),
    const Icon(Icons.favorite_border),
    const Icon(Icons.store_mall_directory_outlined),
    const Icon(Icons.add_shopping_cart_sharp),
    const Icon(Icons.notifications_active_outlined)
  ];
  int d = 2;
  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MaterialApp(
          home: Scaffold(
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
                items: icons),
          ),
        )
      : Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.done_rounded),
                color: Colors.red,
              )
            ],
          ),
        );
}
