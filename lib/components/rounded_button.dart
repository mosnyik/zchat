import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback function;

  const RoundedButton({
    Key? key,
    required this.buttonText,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          elevation: 5.0,
          color: kAppBarBackgroundColor,
          onPressed: function,
          minWidth: 200,
          height: 42,
          child: Text(buttonText),
        ),
      ),
    );
  }
}
