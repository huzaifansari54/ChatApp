import 'package:chat/Constants/Utils.dart';
import 'package:chat/Service/firebase/Auth/Firbase_Auth.dart';
import 'package:chat/Service/firebase/DataBase/DataCurdFunction.dart';
import 'package:chat/Service/firebase/DataBase/FirbaseDataBase.dart';
import 'package:chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthFunctions extends ChangeNotifier {
  AuthFunctions({@required this.ref});
  final Ref ref;

  Stream<User> getCurrentUser() {
    try {
      final user = ref.read(authProvider).getCurrentUser();

      return user;
    } catch (err) {
      return Stream.error(err);
    }
  }

  void signOut() async {
    await ref.read(authProvider).signOut();
    notifyListeners();
  }

  void signUp(
      String email, String password, String name, String profilePic) async {
    await ref.read(authProvider).signUp(email, password);
    final currentUser = await getCurrentUser().first;
    final user = UserModel(currentUser.uid, email, name, profilePic);
    ref.watch(dataBaseChangenotifierPro.notifier).setUser(user);
    notifyListeners();
  }

  void signIn(String email, String password) {
    ref.read(authProvider).signIn(email, password);
    notifyListeners();
  }
}

final authFunctionProvider = ChangeNotifierProvider<AuthFunctions>((ref) {
  return AuthFunctions(ref: ref);
});
final getUserProvider = StreamProvider((ref) {
  final user = AuthFunctions(ref: ref).getCurrentUser();
  return user;
});
