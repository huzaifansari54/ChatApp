import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../../Service/firebase/Auth/AuthFunction.dart';
import '../../components/primary_button.dart';
import '../../constants.dart';
import '../welcome/signup_Screen.dart';
import 'SignUp_Screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child: Text(
              'SignIn',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: kPrimaryColor),
            )),
            const Spacer(),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    EmailForm(
                      value: (value) {
                        if (value.trim.call().isEmpty) {
                          return 'Please fil Email';
                        }
                        return null;
                      },
                      textEditingController: emailController,
                      hint: 'email',
                      obscure: false,
                      iconData: Icons.email_outlined,
                    ),
                    EmailForm(
                      value: (value) {
                        if (value.trim.call().isEmpty) {
                          return 'Please fill pasword';
                        }
                        return null;
                      },
                      textEditingController: passwordController,
                      hint: 'Password',
                      obscure: true,
                      iconData: Icons.password_outlined,
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                text: 'SIGNIN',
                press: () {
                  if (_formkey.currentState.validate()) {
                    ref
                        .read(authFunctionProvider.notifier)
                        .signIn(emailController.text, passwordController.text);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  }
                }),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
