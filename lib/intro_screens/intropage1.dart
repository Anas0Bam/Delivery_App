import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Intropage1 extends StatelessWidget {
  Intropage1(
      {super.key,
      required this.titletext,
      required this.imagetitle,
      required this.subtitle});

  String titletext;
  String imagetitle;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var widthg = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          height: height* 0.7  ,
          width: widthg* 0.7,
          image: AssetImage(imagetitle),
        ),
        Text(
          titletext,
          textAlign: TextAlign.center,
          style:   TextStyle(fontWeight: FontWeight.bold, fontSize: widthg* 0.070),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style:   TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black45,
            fontSize: widthg  *   0.05,
          ),
        ),
        const Spacer()
      ],
    );
  }
}
