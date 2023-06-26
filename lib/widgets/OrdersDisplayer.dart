import 'package:deliver_app/widgets/Invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CardDisplayer extends StatelessWidget {
  final bool orderstatus;
  final String storename;

  final String order_details;
  final String orderdate;
  final String ordernumber;
  CardDisplayer(
      {required this.storename,
      required this.orderstatus,
      required this.ordernumber,
      required this.order_details,
      required this.orderdate});

  Widget build(BuildContext context) {
    var widthg = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 9,
      margin: EdgeInsets.only(
        right: widthg * 00.02,
        left: widthg * 0.02,
        top: height * 0.010,
        bottom: height * 0.005,
      ),
      child: ListTile(
        leading: Image.asset(
          'assets/store-place.png',
          scale: 10,
        ),
        title: Text(
          storename,
          style: TextStyle(
              fontSize: widthg * 0.05,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        titleTextStyle: TextStyle(color: Colors.blue),
        subtitle: orderstatus
            ? Text(
                AppLocalizations.of(context)!.completed,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            : Text(
                AppLocalizations.of(context)!.pending,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
        trailing: Text(
          "5 " + AppLocalizations.of(context)!.money,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onTap: () => showBottomSheet(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Invoice(
                image: 'assets/store-place.png',
                storename: storename,
                orderes: order_details,
                time: orderdate,
                order_number: ordernumber,
              );
            }),
      ),
    );
  }
}
