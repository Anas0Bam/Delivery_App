import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Invoice extends StatelessWidget {
  final String image;
  final String storename;
  final String orderes;
  final String time;
  final String order_number;
  const Invoice(
      {required this.image,
      required this.storename,
      required this.orderes,
      required this.time,
      required this.order_number});

  @override
  Widget build(BuildContext context) {
    var widthg = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      margin: EdgeInsets.only(
        top: height * 0.2,
      ),
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: ListTile(
              leading: Image.asset(
                scale: widthg * 0.018,
                image,
              ),
              title: Text(
                storename,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(' ${time}'), Text(order_number)],
              ),
              trailing: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: TextFormField(
              readOnly: true,
              initialValue: orderes,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                enabled: true,
                labelText: AppLocalizations.of(context)!.details,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                floatingLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 10),
                child: Text(
                  AppLocalizations.of(context)!.fees,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
