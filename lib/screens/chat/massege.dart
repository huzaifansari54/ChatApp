import 'package:chat/Service/firebase/DataBase/DataCurdFunction.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatRoom.dart';
import 'package:chat/models/User.dart';
import 'package:chat/screens/chat/Message_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/ChatMessage.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({this.chat, this.user, Key key, this.currentUser})
      : super(key: key);

  final UserModel chat;
  final User currentUser;
  final UserModel user;

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final chatrooms = ref
        .read(dataBaseChangenotifierPro.notifier)
        .getChatRoom(widget.chat.uid, widget.currentUser.uid);
    return FutureBuilder<ChatRoom>(
        future: chatrooms,
        builder: (context, chatroom) {
          if (!chatroom.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                AssetImage(widget.chat.profilePic)),
                        if (true)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      width: 2)),
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Opacity(opacity: 0.8, child: Text(widget.chat.name)),
                    ],
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.local_phone),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Icon(Icons.videocam),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                    ],
                  ),
                ],
              ),
              body: Consumer(builder: (context, ref, _) {
                final chats = ref
                    .watch(dataBaseChangenotifierPro.notifier)
                    .getChats(chatroom.data.roomid);
                return StreamBuilder<List<ChatMessage>>(
                    stream: chats,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final message = snapshot.data;
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemCount: message.length,
                                  itemBuilder: (context, index) {
                                    final isSender = message[index].isSender ==
                                        widget.currentUser.uid;
                                    return Row(
                                      mainAxisAlignment: isSender
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          alignment: isSender
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 8),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: kPrimaryColor),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      message[index].text,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  ],
                                                )),
                                            !isSender
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1.5)),
                                                      child: CircleAvatar(
                                                        radius: 4,
                                                        backgroundImage:
                                                            AssetImage(widget
                                                                .chat
                                                                .profilePic),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1.5)),
                                                      child: CircleAvatar(
                                                        radius: 4,
                                                        backgroundImage:
                                                            AssetImage(widget
                                                                .user
                                                                .profilePic),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            MessageBody(widget.chat, widget.currentUser),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              }),
            );
          }
        });
  }
}
