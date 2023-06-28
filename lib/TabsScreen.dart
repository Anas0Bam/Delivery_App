import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mnadibapp/Login_screen/VeryfiAut.dart';
import 'package:mnadibapp/Model/globals.dart';
import 'package:mnadibapp/Screens/home-screen.dart';
import 'package:mnadibapp/Service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    } else {
      getDecData(dcoId: FirebaseAuth.instance.currentUser!.uid);
      print(userAccount.toString());
      // getOrders(dcoId: FirebaseAuth.instance.currentUser!.uid);
      // print(orderList);
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
      : VerifyEmailPageState();
}
