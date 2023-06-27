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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          height: 500,
          width: 500,
          image: AssetImage(imagetitle),
        ),
        Text(
          titletext,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black45,
            fontSize: 25,
          ),
        ),
        const Spacer()
      ],
    );
  }
}
