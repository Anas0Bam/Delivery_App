import 'package:flutter/material.dart';

class Invoice extends StatelessWidget {
  final String _image;
  final String _storename;
  final String _orderes;
  final String _time;
  const Invoice(this._image, this._storename, this._orderes, this._time);

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
                _image,
              ),
              title: Text(
                _storename,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(' ${_time}'), Text('#545454f54')],
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
              initialValue: _orderes,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                enabled: true,
                labelText: 'طلبات',
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
                  'رسوم التوصيل 5 ريال',
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
