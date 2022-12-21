import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/Auth/SignIn_Screen.dart';
import 'package:chat/screens/Auth/SignUp_Screen.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Theme.of(context).brightness == ThemeData.light().brightness
                  ? Image.asset(
                      'assets/images/Logo_light.png',
                      height: 126,
                      width: 126,
                    )
                  : Image.asset(
                      'assets/images/Logo_dark.png',
                      height: 126,
                      width: 126,
                    ),
              Spacer(
                flex: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: PrimaryButton(
                    text: 'SIGN UP',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: PrimaryButton(
                    color: kSecondaryColor,
                    text: 'SIGN IN',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    }),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
