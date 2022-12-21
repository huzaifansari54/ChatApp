import 'package:chat/Constants/Utils.dart';
import 'package:chat/Service/Repositories/firebaseRepo.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

class FirebaseDataBaseImplemention extends FirebaseDataBaseRepository {
  const FirebaseDataBaseImplemention({@required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final data = await firestore.collection('users').get();
      final users = data.docs.map((user) {
        return UserModel.fromJson(user.data());
      }).toList();
      if (users != null) {
        return users;
      }
    } catch (e) {
      return Future.error(e);
    }
    return [];
  }

  @override
  Future<bool> setUsers(UserModel userModel) async {
    try {
      await firestore.collection("users").doc().set(userModel.toJson());
      return true;
    } catch (err) {
      Future.error(err);
      return false;
    }
  }

  @override
  Future<ChatRoom> getChatRoom(String userUid, String currentUserUid) async {
    ChatRoom chatRoom = ChatRoom(
        roomid: currentUserUid + userUid,
        lastMsg: "",
        particepants: {userUid: true, currentUserUid: true});
    try {
      final room = await firestore
          .collection("chatrooms")
          .where("particepants.$userUid", isEqualTo: true)
          .where("particepants.$currentUserUid", isEqualTo: true)
          .get();
      if (room.docs.isEmpty) {
        await firestore
            .collection("chatrooms")
            .doc(chatRoom.roomid)
            .set(chatRoom.toJson());
        return chatRoom;
      } else {
        final chatroom = await firestore
            .collection("chatrooms")
            .doc(currentUserUid + userUid)
            .get();
        if (chatroom.exists) {
          return ChatRoom.fromJson(chatroom.data());
        } else {
          final chatroom = await firestore
              .collection("chatrooms")
              .doc(userUid + currentUserUid)
              .get();
          return ChatRoom.fromJson(chatroom.data());
        }
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  @override
  Future<bool> sendMessage(ChatMessage msgModel, ChatRoom room) async {
    try {
      firestore
          .collection('chatrooms')
          .doc(room.roomid)
          .collection('messages')
          .doc(msgModel.messageId)
          .set(msgModel.toJson());
      return true;
    } catch (err) {
      Future.error(err);
    }
    return false;
  }

  @override
  Stream<List<ChatMessage>> getChats(String roomId) {
    try {
      final chats = firestore
          .collection('chatrooms')
          .doc(roomId)
          .collection('messages')
          .orderBy("createdOnTime", descending: true)
          .snapshots();
      final chat = chats.map((event) =>
          event.docs.map((e) => ChatMessage.fromJson(e.data())).toList());
      return chat;
    } catch (err) {
      Stream.error(err);
    }
    return Stream.empty();
  }

  @override
  Future<UserModel> getUser(String id) async {
    try {
      final user =
          await firestore.collection('users').where('uid', isEqualTo: id).get();
      final myUser = user.docs.map((e) => UserModel.fromJson(e.data())).first;
      return myUser;
    } catch (err) {
      Future.error(err);
    }
    return Future.error("User is not Found");
  }
}

final dataBaseProvider = Provider<FirebaseDataBaseImplemention>((ref) {
  return FirebaseDataBaseImplemention(firestore: FirebaseFirestore.instance);
});
final userModelProvider = FutureProvider.family((ref, String id) {
  final dataBase = ref.watch(dataBaseProvider).getUser(id);
  return dataBase;
});
