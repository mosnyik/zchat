import 'package:flutter/material.dart';
import 'package:zchat/constants.dart';
import 'package:zchat/screens/chat_screen.dart';
import 'package:zchat/screens/login_screen.dart';
import 'package:zchat/screens/registeration_screen.dart';
import 'package:zchat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ZChat());
}

class ZChat extends StatelessWidget {
  const ZChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterationScreen.id: (context) => const RegisterationScreen(),
      },
    );
  }
}
