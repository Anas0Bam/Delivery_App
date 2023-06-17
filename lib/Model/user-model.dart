import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccount {
  String _id;
  String _name;
  String _email;
  String _phoneNumber;

  UserAccount(
      this._id,
      this._name,
      this._email,
      this._phoneNumber,
      );

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Email": _email.toString(),
      "uid": _id.toString(),
      "username": _name.toString(),
      "phoneNumber": _phoneNumber.toString(),
    };
  }
  //

  factory UserAccount.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserAccount(
      data?["uid"],
      data?["username"],
      data?["Email"],
      data?["phoneNumber"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
    };
  }
}
