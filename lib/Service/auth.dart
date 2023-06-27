import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:deliver_app/Model/globals.dart';
import 'package:deliver_app/Model/user-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String> getDecData({required String dcoId}) async {
  // if (await InternetOff()) {
  //   return 'No internet connection';
  // }

  // Firestore operations when internet connection is available
  try {
    final ref =
        FirebaseFirestore.instance.collection("Users").doc(dcoId).withConverter(
              fromFirestore: UserAccount.fromFirestore,
              toFirestore: (UserAccount user, _) => user.toFirestore(),
            );

    final snapshot = await ref.get();
    print(snapshot.data());
    final userAccountNow = snapshot.data();

    if (userAccountNow != null) {
      userAccount = userAccountNow;
      print(userAccount.email);
      return "document is found";
    } else {
      print("crash");
      return "No document found";
    }
  } catch (error) {
    return "Error fetching user data: $error";
  }
}

// Future<String> getOrders({required String dcoId}) async {
//   // if (await InternetOff()) {
//   //   return 'No internet connection';
//   // }

//   // Firestore operations when internet connection is available
//   try {
//     final ref = FirebaseFirestore.instance
//         .collection("orders")
//         .where("User ID", isEqualTo: dcoId)
//         .withConverter(
//           fromFirestore: OrderList.fromFirestore,
//           toFirestore: (OrderList user, _) => user.toFirestore(),
//         );

//     final snapshot = await ref.get();
//     print(snapshot.docs);
//     final userAccountNows = snapshot.docs;

//     // ignore: unnecessary_null_comparison
//     if (userAccountNows != null) {
//       orderList = userAccountNows as OrderList;
//       print(userAccount.email);
//       return "document is found";
//     } else {
//       print("crash");
//       return "No document found";
//     }
//   } catch (error) {
//     return "Error fetching user data: $error";
//   }
// }

Future<void> updateOrderStatus() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where(
        'User ID',
        isEqualTo: FirebaseAuth.instance.currentUser,
      )
      .where('Order Status', isEqualTo: false)
      .get();

  DocumentSnapshot doc = snapshot.docs.first;
  doc.reference.update({'Order Status': true});
}




Future<List<Map<String, dynamic>>> printOrders() async {
  final List<DocumentSnapshot> orders = await getOrdersForUser();
  final List<Map<String, dynamic>> orderDataList = [];

  for (final DocumentSnapshot order in orders) {
    final data = order.data() as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
    orderDataList.add(data);
  }

  // Print the order data
  orderDataList.forEach((orderData) {
    print(orderData);
    print(orderDataList.length);
  });

  return orderDataList;
}

Future<List<DocumentSnapshot>> getOrdersForUser() async {
  final currentUser1 = FirebaseAuth.instance.currentUser!.uid;

  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('User ID', isEqualTo: currentUser1)
      .where('Order Status', isEqualTo: false)
      .get();

  return querySnapshot.docs;
}

Future<List<DocumentSnapshot>> reciveOrders() async {
  final currentUser1 = FirebaseAuth.instance.currentUser!.uid;

  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('User ID', isEqualTo: currentUser1)
      .where('Order Status', isEqualTo: false)
      .get();

  final List<DocumentSnapshot> orders = querySnapshot.docs;

  for (final DocumentSnapshot order in orders) {
    final DocumentReference orderRef = order.reference;
    await orderRef.update({'Order Status': true});
  }

  return orders;
}


