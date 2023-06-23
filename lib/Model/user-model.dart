import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccount {
  String Address;
  String _fname;
  String _lname;
  String _email;
  String _phoneNumber;

  UserAccount(
      this.Address,
      this._fname,
      this._lname,
      this._email,
      this._phoneNumber,
      );

  String get id => Address;

  set id(String value) {
    Address = value;
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
      "Address": Address.toString(),
      "First Name": _fname.toString(),
      "Last Name": _lname.toString(),
      "Phone Number": _phoneNumber.toString(),
    };
  }
  //

  factory UserAccount.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserAccount(
      data?["Address"],
      data?["First Name"],
      data?["Last Name"],
      data?["Email"],
      data?["Phone Number"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "Address": Address,
      "First Name": _fname,
      "Last Name": _lname,
      "Email": email,
      "Phone Number": phoneNumber,
    };
  }

  @override
  String toString() {
    return 'UserAccount{Address: $Address, _fname: $_fname, _lname: $_lname, _email: $_email, _phoneNumber: $_phoneNumber}';
  }
}
