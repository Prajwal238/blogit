import 'dart:developer';

import 'package:blogit/models/blog_model.dart';
import 'package:blogit/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  addBlogData(BlogModel blog) async {
    await _db.collection("Blogs").doc(blog.bid).set(blog.toMap());
  }
  Future<bool> checkIfBlogIsSaved(String bid, String uid) async{

    final savedBlogData = await _db.collection("SavedBlogs")
      .where(FieldPath.documentId, isEqualTo: uid)
      .where('savedBlogIds', arrayContains: bid).get();
      return savedBlogData.docs.isNotEmpty;
  }
  addToSavedBlogs(String bid, String uid, bool flag) async {
    final snapshot = await _db.collection("SavedBlogs").doc(uid).get();
    if(snapshot.exists) {
      if(!flag) {
        await _db.collection("SavedBlogs").doc(uid).update({"savedBlogIds": FieldValue.arrayUnion([bid])});
      } if(flag) {
        await _db.collection("SavedBlogs").doc(uid).update({"savedBlogIds": FieldValue.arrayRemove([bid])});
      }
    } else {
      await _db.collection("SavedBlogs").doc(uid).set({"savedBlogIds": [bid]});
    }
  }

  Future<List<BlogModel>> retrieveUsersSavedBlogs(String uid) async {
    late DocumentSnapshot<Map<String, dynamic>> snapshot;
    final savedBlogs = await _db.collection("SavedBlogs").doc(uid).get().then((doc) {
      return doc.get('savedBlogIds');
    });
    List<BlogModel> savedBlogsListofUser = [];
    for(var savedblogid = 0; savedblogid < savedBlogs.length; savedblogid+=1) {
      log("inside for loop");
      snapshot = await _db.collection('Blogs').doc(savedBlogs[savedblogid]).get();
      savedBlogsListofUser.add(BlogModel.fromDocumentSnapshot(snapshot));
    }
    return savedBlogsListofUser;
  }

  Future<List<BlogModel>> listBasedOnSearch(String query) async {
    log("inside Repo: " + query);
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("Blogs").where('title', isGreaterThanOrEqualTo: query)
    .where('title', isLessThanOrEqualTo: '$query\uf8ff').get();
    inspect(snapshot);
    return snapshot.docs.map((docSnapshot) => BlogModel.fromDocumentSnapshot(docSnapshot)).toList();
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").get();
    return snapshot.docs.map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot)).toList();
  }

  Future<List<BlogModel>> retrieveBlogs() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("Blogs").get();
    return snapshot.docs.map((docSnapshot) => BlogModel.fromDocumentSnapshot(docSnapshot)).toList();
  }

  Future<String> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!["displayName"];
  }
}
