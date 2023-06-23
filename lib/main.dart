import 'package:colours/colours.dart';
import 'package:deliver_app/Login_screen/auth_page.dart';

import 'package:deliver_app/intro_screens/onboardingscreen.dart';
import 'package:deliver_app/l10n/l10n.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  // final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: AuthPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Schyler",
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          color: Colors.white,
        ),
        canvasColor: Colours.lightSkyBlue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colours.lightSkyBlue),
      ),

      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home': (context) => AuthPage(),
        'onboard': (context) => Onboardingscreen(),
      },
      // home: showHome ? AuthPage() : Onboardingscreen(),
      // routes: {
      //   '/': (_) => AuthPage(),
      // },
    );
  }
}
