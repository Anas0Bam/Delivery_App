import 'package:colours/colours.dart';
import 'package:deliver_app/Login_screen/auth_page.dart';
import 'package:deliver_app/ScreenPages/more.dart';
import 'package:deliver_app/l10n/l10n.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:deliver_app/TabsScreen.dart';
// import 'package:deliver_app/intro_screens/mainintroscreens.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HomePage());
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
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          color: Colors.white,
        ),
        canvasColor: Colours.lightSkyBlue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: Colours.lightSkyBlue),
      ),

      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (currentLang, supportLan) {
        if (currentLang != null) {
          for (Locale local in supportLan) {
            if (local.languageCode == currentLang.languageCode) {
              return currentLang;
            }
          }
        }
      },
      home: AuthPage(),
      // routes: {
      //   '/': (_) => AuthPage(),
      // },
    );
  }
}
