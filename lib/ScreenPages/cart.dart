import 'package:flutter/material.dart';

// ignore: camel_case_types
class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('cart'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
