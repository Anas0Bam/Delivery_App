import 'package:cloud_firestore/cloud_firestore.dart';

class OrderList {
  String _Order_Date;
  String _Order_Number;
  bool _Order_Status;
  String _Place_Name;
  String _User_ID;

  OrderList(
    this._Order_Date,
    this._Order_Number,
    this._Order_Status,
    this._Place_Name,
    this._User_ID,
  );

  String get date => _Order_Date;

  set id(String value) {
    _Order_Date = value;
  }

  String get Order_Number => _Order_Number;

  set Order_Number(String value) {
    _Order_Number = value;
  }

  bool get Order_Status => _Order_Status;

  set Order_Status(bool value) {
    _Order_Status = value;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Order Date": _Order_Date.toString(),
      "Order Number": _Order_Number.toString(),
      "Order Status": _Order_Status.toString(),
      "Place Name": _Place_Name.toString(),
      "User ID": _User_ID.toString(),
    };
  }
  //

  factory OrderList.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderList(
      data?["Order Date"],
      data?["Order Number"],
      data?["Order Status"],
      data?["Place Name"],
      data?["User ID"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "Order Date": date,
      "Order Number": Order_Number,
      "Order Status": Order_Status,
      "Place Name": _Place_Name,
      "User ID": _User_ID,
    };
  }

  @override
  String toString() {
    return 'OrderList{Order Date: $date, Order Number: $Order_Number, Order Status: $Order_Status, Place Name: $_Place_Name, User ID: $_User_ID}';
  }
}

class order {
  bool s;
  order(this.s);
}
