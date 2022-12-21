import 'package:chat/Constants/Utils.dart';
import 'package:chat/Service/firebase/Auth/AuthFunction.dart';
import 'package:chat/Service/firebase/DataBase/FirbaseDataBase.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/ChatRoom.dart';
import 'package:chat/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Repositories/firebaseRepo.dart';

class FirebaseDataFunction extends ChangeNotifier {
  FirebaseDataFunction(this._firebaseDataBaseRepository, {@required this.ref});
  final Ref ref;
  final FirebaseDataBaseRepository _firebaseDataBaseRepository;

  void setUser(UserModel userModel) async {
    await _firebaseDataBaseRepository.setUsers(userModel);
    notifyListeners();
  }

  Future<List<UserModel>> getAllUser() async {
    final users = await ref.watch(dataBaseProvider).getUsers();
    return users;
  }

  Future<ChatRoom> getChatRoom(String userUid, String currentUserUid) async {
    final chatroom =
        await ref.watch(dataBaseProvider).getChatRoom(userUid, currentUserUid);
    return chatroom;
  }

  Future<void> sendMessage(
      {String currentUserId, String userId, String message}) async {
    final room = await getChatRoom(userId, currentUserId);
    final msgModel = ChatMessage(
        messageId: Utils.uid,
        createdOnTime: DateTime.now(),
        text: message,
        isSeen: false,
        isSender: userId);
    await _firebaseDataBaseRepository.sendMessage(msgModel, room);
  }

  Stream<List<ChatMessage>> getChats(String roomId) {
    final chats = ref.watch(dataBaseProvider).getChats(roomId);
    return chats;
  }
}

final dataBaseChangenotifierPro =
    ChangeNotifierProvider<FirebaseDataFunction>((ref) {
  return FirebaseDataFunction(
      FirebaseDataBaseImplemention(firestore: FirebaseFirestore.instance),
      ref: ref);
});
