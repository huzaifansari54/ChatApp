import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String messageId;
  final String text;
  final bool isSeen;
  final String isSender;
  final DateTime createdOnTime;

  ChatMessage({
    @required this.messageId,
    @required this.createdOnTime,
    @required this.text,
    @required this.isSeen,
    @required this.isSender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> map) {
    return ChatMessage(
        messageId: map["messageId"],
        text: map['text'],
        isSeen: map["status"],
        isSender: map["isSender"],
        createdOnTime: map["createdOnTime"].toDate());
  }
  Map<String, dynamic> toJson() {
    return {
      "messageId": messageId,
      "text": text,
      "status": isSeen,
      "isSender": isSender,
      "createdOnTime": createdOnTime
    };
  }
}

List demeChatMessages = [
  // ChatMessage(
  //   text: "Hi Sajol,",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Hello, How are you?",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.audio,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.video,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "Error happend",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_sent,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "This looks great man!!",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Glad you like it",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_view,
  //   isSender: true,
  // ),
];
