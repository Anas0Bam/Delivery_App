// import 'package:deliver_app/Login_screen/LoginOrRegister.dart';
import 'package:mnadibapp/Login_screen/LoginOrRegister.dart';
import 'package:mnadibapp/TabsScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return TabsScreen();
          } else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
