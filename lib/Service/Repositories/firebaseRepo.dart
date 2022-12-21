import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/User.dart';

abstract class FirebaseDataBaseRepository {
  const FirebaseDataBaseRepository();
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUser(String id);
  Future<bool> setUsers(UserModel userModel);
  Future<ChatRoom> getChatRoom(String userUid, String currentUserUid);
  Future<bool> sendMessage(ChatMessage msgModel, ChatRoom room);
  Stream<List<ChatMessage>> getChats(String roonId);
}

abstract class FirebaseAuthRepository {
  const FirebaseAuthRepository();
  Stream<User> getCurrentUser();

  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}
