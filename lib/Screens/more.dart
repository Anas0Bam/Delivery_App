import 'package:deliver_app/intro_screens/onboardingscreen.dart';
// import 'package:deliver_app/intro_screens/onboardingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Screens/ProfilePage.dart';
import '../providers/language-provider.dart';

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
    var height = MediaQuery.of(context).size.height;
    var widthg = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            AppLocalizations.of(context)!.more,
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
              }, AppLocalizations.of(context)!.profilePgae, Icons.person,
                  Colors.black),
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
                          content:
                              Text(AppLocalizations.of(context)!.aboutustext),
                        );
                      }),
                  AppLocalizations.of(context)!.aboutus,
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
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Onboardingscreen())));
              }, AppLocalizations.of(context)!.logout, Icons.logout,
                  Colors.red),
              Divider(
                indent: 15,
                endIndent: 15,
                color: Colors.white,
                thickness: 3,
              ),
              cardw(
                  () => showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          height: height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.selectLnaguage,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: widthg * 0.04)),
                              TextButton(
                                onPressed: () {
                                  final provider = Provider.of<LocalProvider>(
                                      context,
                                      listen: false);
                                  provider
                                      .changeLanguage('ar')
                                      .then((value) => Navigator.pop(context));
                                },
                                child: Text('العربية',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: widthg * 0.05)),
                              ),
                              Divider(
                                indent: 5,
                                endIndent: 5,
                                thickness: widthg * 0.01,
                                color: Colors.black45,
                              ),
                              TextButton(
                                onPressed: () {
                                  final provider = Provider.of<LocalProvider>(
                                      context,
                                      listen: false);
                                  provider
                                      .changeLanguage('en')
                                      .then((value) => Navigator.pop(context));
                                },
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: widthg * 0.05),
                                ),
                              ),
                              Divider(
                                  indent: 5,
                                  endIndent: 5,
                                  color: Colors.black45,
                                  thickness: widthg * 0.01),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: widthg * 0.05)),
                              )
                            ],
                          ),
                        );
                      }),
                  AppLocalizations.of(context)!.language,
                  Icons.language,
                  Colors.black),
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
        backgroundColor: Theme.of(context).colorScheme.background);
  }
}
