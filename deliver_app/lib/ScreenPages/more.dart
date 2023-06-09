import 'package:deliver_app/ScreenPages/ProfilePage.dart';
// import 'package:deliver_app/intro_screens/onboardingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class more extends StatelessWidget {
  const more({super.key});
  Widget cardw(Function() d, String label, IconData ic, Color colo) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        splashColor: Colors.white,
        iconColor: colo,
        textColor: Colors.black,
        onTap: d,
        title: Text(label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: Icon(ic, size: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            elevation: 2,
            centerTitle: true,
            backgroundColor: Theme.of(context).canvasColor,
            title: Text(
              'More',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Stack(children: [
            Column(
              children: [
                cardw(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }));
                }, 'Profile page', Icons.person, Colors.black),
                Divider(
                  color: Colors.white,
                  thickness: 3,
                  indent: 15,
                  endIndent: 15,
                ),
                cardw(
                    () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'Mnadib is a comapny that services you in the same neighbourhood without needing to request a far carrior'),
                          );
                        }),
                    'About us',
                    Icons.info,
                    Colors.black),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                  thickness: 3,
                ),
                cardw(() async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setBool('showHome', false);
                  FirebaseAuth.instance.signOut();
                }, 'Logout', Icons.logout, Colors.red),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                  thickness: 3,
                ),
              ],
            ),
            Align(
                child: Text(
                  'Version build:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                alignment: Alignment(0, 0.3))
          ]),
          backgroundColor: Theme.of(context).colorScheme.background),
    );
  }
}
