import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Favorite'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
