import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;
  UserModel({this.uid, this.email, this.password, this.displayName, this.age,this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'age': age,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        age = doc.data()!["age"],
        displayName = doc.data()!["displayName"];

  @override
  String toString() {
    return 'UserModel(uid: $uid, isVerified: $isVerified, email: $email, password: $password, displayName: $displayName, age: $age)';
  }

  UserModel copyWith({
    String? uid,
    bool? isVerified,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      isVerified: isVerified ?? this.isVerified,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
    );
  }
}
