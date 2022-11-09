import 'package:flutter/material.dart';
import 'package:zchat/components/rounded_button.dart';
import 'package:zchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zchat/screens/chat_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);
  static String id = 'register_screen';

  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpiner = false;
  String email = '';
  String password = '';
  String name = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: kAppBarBackgroundColor,
      ),
      body: BlurryModalProgressHUD(
        inAsyncCall: showSpiner,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitWave(
          color: kAppBarBackgroundColor,
          size: 40.0,
        ),
        child: Padding(
          padding: kBodyPadding,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: Container(
                  child: Column(
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Container(
                          child: const Icon(
                            Icons.chat,
                            size: 120,
                            color: kAppBarBackgroundColor,
                          ),
                          height: 150,
                        ),
                      ),
                      Padding(
                        padding: kInputBodyPadding,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: kAppBarBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Please enter your name here',
                            hintStyle: const TextStyle(color: kFocusColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kFocusColor, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kAppBarBackgroundColor)),
                          ),
                          obscureText: false,
                          obscuringCharacter: '*',
                          style: kThemeTextColor,
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: kInputBodyPadding,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: kAppBarBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Please enter your email here',
                            hintStyle: const TextStyle(color: kFocusColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kFocusColor, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kAppBarBackgroundColor)),
                          ),
                          obscureText: false,
                          obscuringCharacter: '*',
                          style: kThemeTextColor,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: kInputBodyPadding,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: kAppBarBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Please enter your password here',
                            hintStyle: const TextStyle(color: kFocusColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kFocusColor, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kAppBarBackgroundColor)),
                          ),
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: kThemeTextColor,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                      RoundedButton(
                        buttonText: 'Register',
                        function: () async {
                          setState(() {
                            showSpiner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              setState(() {
                                showSpiner = false;
                              });
                              Navigator.pushNamed(context, ChatScreen.id);
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                            }
                          } catch (e) {
                            setState(() {
                              showSpiner = false;
                            });
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
