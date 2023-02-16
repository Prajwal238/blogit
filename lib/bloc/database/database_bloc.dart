import 'package:blogit/models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_model.dart';
import '../../repositories/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserBlogData);
    on<CreatingBlog>(_addBlogtoFirebase);
    on<SavedBlogsFetched>(_fetchUserSavedBlog);
    // on<SavingBlog>(_saveChosenBlog);
  }

  _fetchUserBlogData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
      List<UserModel> listofUserData = await _databaseRepository.retrieveUserData();
      List<BlogModel> listofBlogs = await _databaseRepository.retrieveBlogs();
      emit(DatabaseSuccess(listofUserData,listofBlogs,event.displayName));
  }

  _addBlogtoFirebase(CreatingBlog event, Emitter<DatabaseState> emit) async {
    Uuid bid = const Uuid();
    BlogModel blog = BlogModel(bid: bid.v1(),title: event.title, content: event.content, displayName: event.displayName);
    await _databaseRepository.storeBlogData(blog);
    emit(BlogAddedToDatabase());
  }

  _fetchUserSavedBlog(SavedBlogsFetched event, Emitter<DatabaseState> emit) async {
    List<BlogModel> listofSavedBlogs = await _databaseRepository.retrieveSavedBlogs(event.uid!);
    emit(SavedDatabaseSuccess(listofSavedBlogs));
  }

  // _saveChosenBlog(SavingBlog event, Emitter<DatabaseState> emit) async {
  //   await _databaseRepository.saveBlog(event.bid, event.uid);
  //   emit(SavedTheBlog());
  // }
}
