import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return  UserModel(uid: "uid");
      }
    });
  }

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
      verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch(err) {
      throw FirebaseAuthException(code: err.code, message: err.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch(err) {
      throw FirebaseAuthException(code: err.code, message: err.message);
    }
  }

  Future <void> logOut() async {
    return await auth.signOut();
  }

  Future <void> resetPswd(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyEmail() async {
    User? user = auth.currentUser;
    if(user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }
}