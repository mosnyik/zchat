// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:zchat/components/rounded_button.dart';
import 'package:zchat/constants.dart';
import 'package:zchat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpiner = false;
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: kAppBarBackgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: BlurryModalProgressHUD(
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
                  padding: kInputBodyPadding,
                  child: Container(
                    child: Column(
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Container(
                            child: const Icon(
                              Icons.chat,
                              size: 85,
                              color: kAppBarBackgroundColor,
                            ),
                            // height: 150,
                          ),
                        ),
                        Padding(
                          padding: kInputBodyPadding,
                          child: TextFormField(
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Your email can not be blank';
                              }
                            },
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
                          buttonText: 'Log In',
                          function: () async {
                            setState(() {
                              showSpiner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, ChatScreen.id);
                                _emailController.clear();
                                _passwordController.clear();
                                setState(() {
                                  showSpiner = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Log in successfull'),
                                    backgroundColor: kAppBarBackgroundColor,
                                  ));
                                });
                              }
                            } catch (e) {
                              setState(() {
                                showSpiner = true;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Log in failed, check your connection and try again'),
                                  backgroundColor: kAppBarBackgroundColor,
                                ));
                              });
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// UserCredential(
//   additionalUserInfo: 
//   AdditionalUserInfo(isNewUser: false, profile: {}, providerId: password, username: null),
//      credential: null, 
//      user: User(displayName: null, email: moses@gmail.com, emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-03-01 17:38:11.028, lastSignInTime: 2022-03-01 18:10:43.619), 
//      phoneNumber: null, photoURL: null, providerData,
//       [UserInfo(displayName: null, email: moses@gmail.com, phoneNumber: null, photoURL: null, providerId: password, uid: moses@gmail.com)], 
//       refreshToken: , tenantId: null, uid: rjz3s6nlKiQzTHqllkiZnxx2dzN2)
//       )
