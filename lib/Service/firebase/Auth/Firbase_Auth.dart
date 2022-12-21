import 'package:chat/Service/Repositories/firebaseRepo.dart';
import 'package:chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

class FirbaseAuthImplementaion extends FirebaseAuthRepository {
  const FirbaseAuthImplementaion({
    @required this.auth,
  });
  final FirebaseAuth auth;

  @override
  Stream<User> getCurrentUser() {
    final currentUser = auth.idTokenChanges();
    return currentUser;
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Future.error(e);
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Future.error(e);
    }
  }
}

final authProvider = Provider<FirbaseAuthImplementaion>(
    (ref) => FirbaseAuthImplementaion(auth: FirebaseAuth.instance));
