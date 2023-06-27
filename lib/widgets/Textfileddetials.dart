import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController? textController;
  final String hintText;
  final bool obscureText;
  final TextInputType inputTypedis;
  final TextInputFormatter df;
  final String pre;
  // final Icon selectIcon;
  const MyTextfield({
    super.key,
    required this.pre,
    required this.textController,
    required this.hintText,
    required this.obscureText,
    required this.inputTypedis,
    required this.df,
    // required this.selectIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        inputFormatters: <TextInputFormatter>[df],
        keyboardType: inputTypedis,
        showCursor: true,
        controller: textController!,
        obscureText: obscureText,
        decoration: InputDecoration(
            label: Text(
              hintText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            prefixText: pre,
            prefixStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //  icon: selectIcon,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey..shade900)),
      ),
    );
  }
}
