import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../DataTest/orderLists.dart';
import '../widgets/OrdersDisplayer.dart';

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          title: Text(
            'طلباتك',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true),
      body: ListView.builder(
          itemCount: Orderlist.length,
          itemBuilder: (context, index) => CardDisplayer(
              Orderlist[index].image,
              Orderlist[index].namestore,
              Orderlist[index].textChanger,
              Orderlist[index].amount,
              Orderlist[index].orders,
              Orderlist[index].displaytime)),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
