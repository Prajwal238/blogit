import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

abstract class AbsAuthRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> logOut();
  Future<void> resetPswd(String email);
  Future<String?> retrieveUserName(UserModel user);
}

class AuthRepository implements AbsAuthRepository {
  
  AuthService authService = AuthService();
  DatabaseService dbService = DatabaseService();

  @override
  Stream<UserModel> getCurrentUser() {
    return authService.retrieveCurrentUser();
  }

  @override
  Future<void> logOut() {
    return authService.logOut();
  }

  @override
  Future<String?> retrieveUserName(UserModel user) {
    return dbService.retrieveUserName(user);
  }

  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return authService.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return authService.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
  
  @override
  Future<void> resetPswd(String email) async {
    try{
      return await authService.resetPswd(email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

}