import 'package:flutter/material.dart';
import 'package:zchat/components/rounded_button.dart';
import 'package:zchat/constants.dart';
import 'package:zchat/screens/login_screen.dart';
import 'package:zchat/screens/registeration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Padding(
        padding: kBodyPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Icon(
                      Icons.chat,
                      color:
                          kAppBarBackgroundColor.withOpacity(controller.value),
                      size: animation.value * 40,
                    ),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('ZChat',
                        textStyle: kChatTextStyle,
                        speed: const Duration(milliseconds: 240)),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            RoundedButton(
              buttonText: 'Log In',
              function: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              buttonText: 'Register',
              function: () {
                Navigator.pushNamed(context, RegisterationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
