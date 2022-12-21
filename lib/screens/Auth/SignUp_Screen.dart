import 'package:chat/Constants/Utils.dart';
import 'package:chat/Service/firebase/Auth/AuthFunction.dart';
import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/welcome/signup_Screen.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final avtarProvider = StateProvider<String>((ref) => Utils.avatars[0]);

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpPage> {
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
              'SignUp',
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
                    AvatarSelector(),
                    const SizedBox(
                      height: 20,
                    ),
                    EmailForm(
                      value: (value) {
                        if (value.isEmpty) {
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
                        if (value.isEmpty) {
                          return 'Please fil pasword';
                        }
                        return null;
                      },
                      textEditingController: passwordController,
                      hint: 'Password',
                      obscure: true,
                      iconData: Icons.password_outlined,
                    ),
                    EmailForm(
                        hint: 'fullname',
                        obscure: false,
                        iconData: Icons.person,
                        textEditingController: nameController,
                        value: (value) {
                          if (value.isEmpty) {
                            return 'Please fil pasword';
                          }
                          return null;
                        })
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                text: 'SIGNUP',
                press: () {
                  final profile = ref.watch(avtarProvider.notifier).state;
                  print('Click');
                  if (_formkey.currentState.validate()) {
                    ref.read(authFunctionProvider.notifier).signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text,
                        profile);
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

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({
    Key key,
  }) : super(key: key);

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                5,
                (index) => InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                          ref.read(avtarProvider.notifier).state =
                              Utils.avatars[currentIndex];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: currentIndex == index
                                      ? kPrimaryColor.withOpacity(0.5)
                                      : Colors.white,
                                  width: 5),
                              color: kPrimaryColor,
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Utils.avatars[index]),
                          ),
                        ),
                      ),
                    )),
          );
        }),
        Text("Select profile avatar")
      ],
    );
  }
}

class EmailForm extends StatelessWidget {
  const EmailForm({
    Key key,
    @required this.hint,
    @required this.obscure,
    @required this.iconData,
    @required this.textEditingController,
    @required this.value,
  }) : super(key: key);
  final String hint;
  final bool obscure;
  final IconData iconData;
  final TextEditingController textEditingController;
  final FormFieldValidator<String> value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Icon(iconData),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              validator: value,
              controller: textEditingController,
              obscureText: obscure,
              decoration:
                  InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
