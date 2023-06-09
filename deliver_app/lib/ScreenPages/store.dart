import 'package:flutter/material.dart';

class store extends StatelessWidget {
  static const routename = '/store.dart';
  const store({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
            child: Text(
          'stores',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
