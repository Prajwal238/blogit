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
  Future<void> saveBlogData(BlogModel blog) {
    return service.addBlogData(blog);
  }

  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }
  
  @override
  Future<List<BlogModel>> retrieveBlogs() {
    return service.retrieveBlogs();
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<void> saveBlogData(BlogModel blog);
  Future<List<UserModel>> retrieveUserData();
  Future<List<BlogModel>> retrieveBlogs();
}