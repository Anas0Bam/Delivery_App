import 'package:deliver_app/widgets/MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Compoentes/Textfileddetials.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            ));
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      displayMessage(
          'Password reset link was sent to your email!\nplease check your inbux');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'unknown') {
        displayMessage('Please fill up the email section');
      } else if (e.code == 'invalid-email') {
        displayMessage(
            'The entered email is badly formated\nplease enter your email correctly');
      } else if (e.code == 'user-not-found') {
        displayMessage('There is no account registered under this email');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/12.png',
              height: 250,
            ),
            const Text('Enter your Email'),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
                pre: '',
                df: FilteringTextInputFormatter.deny(''),
                inputTypedis: TextInputType.emailAddress,
                //   selectIcon: Icon(Icons.password_outlined),
                hintText: 'email',
                textController: emailcontroller,
                obscureText: false),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              TextLable: 'Reset your password',
              onTap: passwordreset,
            ),
          ],
        ),
      ),
    );
  }
}
