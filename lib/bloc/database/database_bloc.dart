import 'package:blogit/models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../repositories/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserBlogData);
    on<CreatingBlog>(_addBlogtoFirebase);
  }

  _fetchUserBlogData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
      List<UserModel> listofUserData = await _databaseRepository.retrieveUserData();
      List<BlogModel> listofBlogs = await _databaseRepository.retrieveBlogs();
      emit(DatabaseSuccess(listofUserData,listofBlogs,event.displayName));
  }

  _addBlogtoFirebase(CreatingBlog event, Emitter<DatabaseState> emit) async {
    BlogModel blog = BlogModel(title: event.title, content: event.content, displayName: event.displayName);
    await _databaseRepository.saveBlogData(blog);
    emit(BlogAddedToDatabase());
  }
}
