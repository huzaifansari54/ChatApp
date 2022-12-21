import 'package:chat/Service/firebase/DataBase/DataCurdFunction.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageBody extends ConsumerStatefulWidget {
  const MessageBody(this.user, this.currentUserId, {Key key}) : super(key: key);
  final UserModel user;
  final User currentUserId;

  @override
  ConsumerState<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends ConsumerState<MessageBody> {
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child: SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.mic,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        )),
                    child: Row(
                      children: [
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.66),
                        ),
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            maxLines: 1,
                            onTap: () {
                              print('hello');
                            },
                            decoration: InputDecoration(
                              hintText: 'message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: kDefaultPadding / 5,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.66),
                        ),
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: () {
                            if (messageController.text.trim().isNotEmpty) {
                              ref
                                  .read(dataBaseChangenotifierPro.notifier)
                                  .sendMessage(
                                      currentUserId: widget.currentUserId.uid,
                                      userId: widget.user.uid,
                                      message: messageController.text.trim());

                              messageController.clear();
                            }
                          },
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.66),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
