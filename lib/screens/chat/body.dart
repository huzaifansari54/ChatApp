import 'package:chat/Service/firebase/DataBase/DataCurdFunction.dart';
import 'package:chat/components/filled_outline_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/User.dart';
import 'package:chat/screens/chat/massege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends StatelessWidget {
  const Chat({Key key, @required this.currentuser, this.user})
      : super(key: key);
  final User currentuser;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            child: Row(
              children: [
                FillOutlineButton(press: () {}, text: 'Recent'),
                SizedBox(width: kDefaultPadding),
                FillOutlineButton(
                  press: () {},
                  text: 'Active',
                  isFilled: false,
                ),
              ],
            ),
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final chatUser =
              ref.watch(dataBaseChangenotifierPro.notifier).getAllUser();
          return Expanded(
            child: FutureBuilder<List<UserModel>>(
                future: chatUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data
                        .where((user) => user.email != currentuser.email)
                        .toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessageScreen(
                                            user: user,
                                            chat: data[index],
                                            currentUser: currentuser)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                            backgroundImage: AssetImage(
                                                data[index].profilePic)),
                                        if (chatsData[index].isActive)
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                      width: 2)),
                                            ),
                                          )
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Text(
                                              chatsData[index].lastMessage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color
                                                          .withOpacity(0.49)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      chatsData[index].time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color
                                                  .withOpacity(0.49)),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        })
      ],
    );
  }
}
