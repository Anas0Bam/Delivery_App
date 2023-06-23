import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/OrdersDisplayer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('orders')
              .where('User ID', isEqualTo: currentUser1)
              .get(),
          builder: (ctx,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('You havn not made amy orders yet'));
            }
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) => CardDisplayer(
                      orderstatus: documents[index]['Order Status'],
                      storename: documents[index]['Place Name'],
                      order_details: documents[index]['Order Detials'],
                      ordernumber: documents[index]['Order Number'],
                      orderdate: documents[index]['Order Date'],
                    ));
          }),
    );
  }
}
