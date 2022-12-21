import 'package:flutter/cupertino.dart';

class ChatRoom {
  const ChatRoom(
      {@required this.lastMsg, @required this.particepants, this.roomid});
  final String roomid;
  final Map<String, dynamic> particepants;
  final String lastMsg;

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        lastMsg: map["lastMsg"],
        particepants: map["particepants"],
        roomid: map["roomid"]);
  }
  Map<String, dynamic> toJson() {
    return {"lastMsg": lastMsg, "particepants": particepants, "roomid": roomid};
  }
}
