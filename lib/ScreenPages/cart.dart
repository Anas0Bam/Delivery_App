import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/OrdersDisplayer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    Set<int> setOfInts = Set();
    setOfInts.add(Random().nextInt(999999999));
    final currentUser1 = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          title: Text(
            AppLocalizations.of(context)!.order,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc('$currentUser1')
              .collection('orders')
              .doc('$setOfInts')
              .snapshots(),
          builder: (ctx, snapshotd) {
            if (snapshotd.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final userData = snapshotd.data!.data() as Map<String, dynamic>;
            return ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) => CardDisplayer(
                      userData['Place Name'],
                      userData['Order Status'],
                      userData['Order Number'],
                      userData['Order Date'],
                    ));
          }),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
