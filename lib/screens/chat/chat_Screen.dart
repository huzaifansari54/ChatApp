import 'package:chat/Service/firebase/Auth/AuthFunction.dart';
import 'package:chat/Service/firebase/DataBase/FirbaseDataBase.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/Auth/SignUp_Screen.dart';
import 'package:chat/screens/Profile/Profile.dart';
import 'package:chat/screens/welcome/signup_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'body.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final PageController _pageController = PageController();
  int _itemSelectd = 0;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userModelProvider(widget.user.uid));
    return user.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text('Chats',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  ref.read(authFunctionProvider.notifier).signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: PageView(
            onPageChanged: (value) {
              setState(() {
                _itemSelectd = value;
              });
            },
            controller: _pageController,
            children: [
              Chat(
                user: data,
                currentuser: widget.user,
              ),
              Container(),
              Container(),
              ProfileScreen(
                user: data,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.person_add_alt,
              color: Colors.white,
            ),
            backgroundColor: kPrimaryColor,
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _itemSelectd,
              onTap: (value) {
                _pageController.jumpToPage(value);
                setState(() {
                  _itemSelectd = value;
                });
              },
              elevation: 10,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'People'),
                BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
                BottomNavigationBarItem(
                    label: data.name,
                    icon: CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(data.profilePic)))
              ]),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(error),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
