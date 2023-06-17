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
          itemBuilder: (context, index) => DisplayOrders(
              Orderlist[index].image,
              Orderlist[index].namestore,
              Orderlist[index].textChanger,
              Orderlist[index].amount,
              context)),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
