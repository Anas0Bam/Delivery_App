import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final textController;
  final String hintText;
  final bool obscureText;
  final TextInputType inputTypedis;
  // final Icon selectIcon;
  const MyTextfield({
    super.key,
    required this.textController,
    required this.hintText,
    required this.obscureText,
    required this.inputTypedis,
    // required this.selectIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        keyboardType: inputTypedis,
        showCursor: true,
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
            //  icon: selectIcon,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey..shade900)),
      ),
    );
  }
}
