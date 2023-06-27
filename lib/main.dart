import 'package:colours/colours.dart';
import 'package:deliver_app/Login_screen/auth_page.dart';

import 'package:deliver_app/intro_screens/onboardingscreen.dart';
import 'package:deliver_app/l10n/l10n.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/language-provider.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalProvider localProvider = LocalProvider();
  await localProvider.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  // final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider<LocalProvider>.value(
      value: localProvider, child: HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: AuthPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Schyler",
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          color: Colors.white,
        ),
        canvasColor: Colours.lightSkyBlue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: Colours.lightSkyBlue),
      ),
      locale: Provider.of<LocalProvider>(context).locale,
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
