import 'package:chat/models/User.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key, this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(user.profilePic),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(user.name),
          Text(user.email)
        ],
      ),
    );
  }
}
