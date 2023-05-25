import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String TextLable;
  const MyButton({super.key, required this.onTap, required this.TextLable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white38,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 80),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            TextLable,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
