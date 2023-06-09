import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Firna = TextEditingController();
    final lastn = TextEditingController();
    final email = TextEditingController();
    final pho = TextEditingController();
    // final pass = TextEditingController();
    final add = TextEditingController();

    final currentUser1 = FirebaseAuth.instance.currentUser;
    final usercollec = FirebaseFirestore.instance.collection('Users');
    bool dis = false;
    Future<void>? editfield(
        String field,
        TextInputFormatter df,
        TextInputType _inputTypedis,
        TextEditingController _textController,
        String _hintText,
        bool _obscureText,
        String pref) async {
      String newvalue = '';
      String phow = '';
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Edit new ' + field),
                content: TextField(
                  inputFormatters: <TextInputFormatter>[df],
                  onChanged: (value) {
                    newvalue = value;
                  },
                  keyboardType: _inputTypedis,
                  showCursor: true,
                  controller: _textController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      prefixText: pref,
                      prefixStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      label: Text(
                        _hintText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //  icon: selectIcon,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey..shade900)),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(newvalue),
                      child: Text('Next'))
                ],
              ),
          barrierLabel: 'asddsa');
      if (newvalue.trim().length > 0 || phow.trim().length > 0) {
        await usercollec.doc(FirebaseAuth.instance.currentUser!.uid).update({
          field: newvalue,
          if (field == 'Phone Number') field: '+966 ' + newvalue,
        });

        try {
          FirebaseAuth.instance.currentUser!
              .verifyBeforeUpdateEmail(email.text)
              .then((_) =>
                  FirebaseAuth.instance.currentUser!.updateEmail(email.text));
        } catch (e) {
          void displayMessage(String message) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        e.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
          }
        }
        ;
      }
    }

    Widget textfiledediti(
        String infor, Widget iconss, bool showpass, final void Function()? fd) {
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
              onPressed: fd,
            ),
            enabled: true,
          ),
        ),
      );
    }

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
                  .collection('Users')
                  .doc(currentUser1!.uid)
                  .snapshots(),
              builder: (ctx, snapshotd) {
                if (snapshotd.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final userData = snapshotd.data!.data() as Map<String, dynamic>;

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 50),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      textfiledediti(
                          userData['First Name'], Icon(Icons.person), false,
                          () {
                        editfield(
                            'First Name',
                            FilteringTextInputFormatter.deny(''),
                            TextInputType.name,
                            Firna,
                            'First name',
                            false,
                            '');
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      textfiledediti(
                          userData['Last Name'],
                          Icon(
                            Icons.person,
                          ),
                          false, () {
                        editfield(
                            'Last Name',
                            FilteringTextInputFormatter.deny(''),
                            TextInputType.name,
                            lastn,
                            'Last name',
                            false,
                            '');
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      textfiledediti(
                          userData['Phone Number'], Icon(Icons.phone), false,
                          () {
                        editfield(
                            'Phone Number',
                            FilteringTextInputFormatter.digitsOnly,
                            TextInputType.phone,
                            pho,
                            'Enter your new number',
                            false,
                            '+966');
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      textfiledediti(currentUser1.email.toString(),
                          Icon(Icons.email), false, () {
                        editfield(
                            'Email',
                            FilteringTextInputFormatter.deny(''),
                            TextInputType.emailAddress,
                            email,
                            'Enter your new email',
                            false,
                            '');
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      textfiledediti(
                          userData['Address'], Icon(Icons.home_outlined), false,
                          () {
                        editfield(
                            'Address',
                            FilteringTextInputFormatter.deny(''),
                            TextInputType.streetAddress,
                            add,
                            'Your new address',
                            false,
                            '');
                      }),
                    ]);

                // if (snapshotd.hasData) {
                // final userData =
                //     snapshotd.data.() as Map<String, dynamic>;
                // if(snapshotd.connectionState==ConnectionState.waiting){
                //   return Center(child: CircularProgressIndicator(),);
                // }
                // final document=snapshotd.data.dcoments.length,
              }),
          backgroundColor: Theme.of(context).colorScheme.background),
    );
  }
}
