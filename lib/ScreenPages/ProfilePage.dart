import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Future<void>? editfield(String field) {
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    Widget textfiledediti(
      String infor,
      Widget iconss,
      bool showpass,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: Colors.white,
          child: ListTile(
            hoverColor: Colors.white,
            title: Text(infor),
            leading: iconss,
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: Text('data'),
                      )),
            ),
            enabled: true,
          ),
        ),
      );
    }

    final currentUser1 = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            centerTitle: true,
            title: Text(
              'Information details',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser1?.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return ListView(children: [
                    textfiledediti(
                      currentUser1!.email.toString(),
                      Icon(Icons.person),
                      false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textfiledediti(
                      userData['First Name']!,
                      Icon(Icons.person),
                      false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textfiledediti(
                      userData['Last Name']!,
                      Icon(Icons.person),
                      false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textfiledediti(
                      userData['Email']!,
                      Icon(Icons.email),
                      false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textfiledediti(
                      userData['Phone Number']!,
                      Icon(Icons.phone),
                      false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          backgroundColor: Theme.of(context).colorScheme.background),
    );
  }
}
