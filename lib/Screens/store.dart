import 'package:mnadibapp/Model/globals.dart';
import 'package:mnadibapp/Screens/home-screen.dart';
import 'package:flutter/material.dart';

class store extends StatelessWidget {
  static const routename = '/store.dart';

  const store({super.key});

  @override
  Widget build(BuildContext context) {
    print(userAccount.email);
    return HomeScreen();
  }
}
