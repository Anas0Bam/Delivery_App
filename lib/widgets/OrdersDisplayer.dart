import 'package:deliver_app/widgets/Invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CardDisplayer extends StatelessWidget {
  String _image;

  int _amount;
  String _storename;
  bool _textchanger;
  String _orders;
  String _timedisplayer;
  CardDisplayer(this._image, this._storename, this._textchanger, this._amount,
      this._orders, this._timedisplayer);

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
                _textchanger
                    ? Text(
                        AppLocalizations.of(context)!.completed,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        AppLocalizations.of(context)!.pending,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
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
                  "${_amount} " + AppLocalizations.of(context)!.money,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () => showBottomSheet(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Invoice(
                            _image, _storename, _orders, _timedisplayer);
                      }),
                  child: Text(AppLocalizations.of(context)!.deitals,
                      style: TextStyle(decoration: TextDecoration.underline)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
