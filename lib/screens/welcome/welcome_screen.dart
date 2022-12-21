import 'package:chat/Service/firebase/Auth/AuthFunction.dart';
import 'package:chat/Service/firebase/DataBase/FirbaseDataBase.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chat/chat_Screen.dart';
import 'package:chat/screens/welcome/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final cuser = ref.watch(getUserProvider);
      return cuser.when(
        data: (data) {
          return data != null
              ? ChatScreen(
                  user: data,
                )
              : Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Spacer(),
                        Image.asset('assets/images/welcome_image.png'),
                        Spacer(
                          flex: 3,
                        ),
                        Text(
                          'Welcome to Freedom',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Lets start ',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              fontSize: 16),
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        FittedBox(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Skip',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color),
                                  ),
                                  SizedBox(
                                    width: kDefaultPadding / 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 14,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
      );
    });
  }
}
