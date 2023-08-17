import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {

  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String username, String email, String password);
  Future<void> signOut();
  Future<void> deleteAccount();
  User? get user;

}

