import 'package:blogit/models/blog_model.dart';

import '../models/user_model.dart';
import '../services/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  @override
  Future<void> storeBlogData(BlogModel blog) {
    return service.addBlogData(blog);
  }

  @override
  Future<void> saveBlog(String bid, String uid, bool flag) {
    return service.addToSavedBlogs(bid, uid, flag);
  }

  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }
  
  @override
  Future<List<BlogModel>> retrieveBlogs() {
    return service.retrieveBlogs();
  }
  
  @override
  Future<bool> isBlogSaved(String bid, String uid) {
    return service.checkIfBlogIsSaved(bid, uid);
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<void> storeBlogData(BlogModel blog);
  Future<void> saveBlog(String bid, String uid, bool flag);
  Future<bool> isBlogSaved(String bid, String uid);
  Future<List<UserModel>> retrieveUserData();
  Future<List<BlogModel>> retrieveBlogs();
}