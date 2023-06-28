import 'dart:async';

import 'package:flutter/material.dart';

class Dialog extends StatefulWidget {
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  Timer? _timer;
  int _dialogCount = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 3);
    _timer = Timer.periodic(duration, (Timer timer) {
      // Show the dialog every minute
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dialog $_dialogCount'),
            content: Text('This is a dialog that appears every minute.'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Close'),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        // Increment the dialog count
        _dialogCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog Timer'),
      ),
      body: Center(
        child: Text('Dialogs shown: $_dialogCount'),
      ),
    );
  }
}
