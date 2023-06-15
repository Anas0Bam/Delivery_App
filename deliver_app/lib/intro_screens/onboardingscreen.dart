import 'package:deliver_app/Login_screen/LoginOrRegister.dart';
// import 'package:deliver_app/Login_screen/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'intropage1.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Stack(children: [
            PageView(
              onPageChanged: (value) => setState(() {
                onLastPage = (value == 2);
              }),
              controller: _controller,
              children: [
                Intropage1(
                    imagetitle: 'assets/12.png',
                    titletext: 'اطلب من حولك لا تروح بعيد',
                    subtitle: 'نوفر لك من يجيب اغراضك\n من نفس منطقتك'),
                Intropage1(
                    imagetitle: 'assets/loc.png',
                    titletext: 'إختار منطقتك وين ماكانت',
                    subtitle: 'لا تشيل هم المندوب وين ماكنت'),
                Intropage1(
                    imagetitle: 'assets/intro1.png',
                    titletext: ' اطلب الي تبي ونجيبه لين عندك أسرع شيء',
                    subtitle: ''),
              ],
            ),
            Align(
                alignment: const Alignment(0.75, .75),
                child: onLastPage
                    ? InkWell(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginOrRegister();
                          }));
                        })
                    : IconButton(
                        splashRadius: 20,
                        splashColor: Theme.of(context).colorScheme.background,
                        onPressed: () => _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                        icon: const Icon(Icons.arrow_forward))),
            Align(
              alignment: const Alignment(-0.75, 0.75),
              child: SmoothPageIndicator(
                effect: SwapEffect(
                  dotColor: Colors.black.withOpacity(0.12),
                  activeDotColor: Colors.white,
                ),
                controller: _controller,
                count: 3,
              ),
            )
          ])),
    );
  }
}