import 'package:flutter/material.dart';

Widget DisplayOrders(
    String _image, String _storename, bool textchanger, int _amount, context) {
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
    child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: widthg * 0.02,
          ),
          Image.asset(
            _image,
            scale: 10,
          ),
          SizedBox(
            width: widthg * 0.05,
          ),
          Column(
            children: [
              Text(
                _storename,
                style: TextStyle(
                    fontSize: widthg * 0.05, fontWeight: FontWeight.bold),
              ),
              textchanger
                  ? Text(
                      "Pending",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Completed",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: widthg,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 00.02),
              Text(
                textDirection: TextDirection.rtl,
                "${_amount} " + "ريال",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: widthg * 0.09,
                            right: widthg * 0.09,
                            top: height * 0.2,
                            bottom: height * 0.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Detials'),
                              ],
                            ),
                          ],
                        ),
                        color: const Color.fromARGB(255, 244, 244, 244),
                      );
                    }),
                child: Text("Details order",
                    style: TextStyle(decoration: TextDecoration.underline)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
