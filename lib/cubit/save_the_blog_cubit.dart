import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repositories/database_repository.dart';

part 'save_the_blog_state.dart';

class SaveTheBlogCubit extends Cubit<SaveTheBlogState> {
  SaveTheBlogCubit(this._databaseRepository) : super(SaveTheBlogInitial());
  final DatabaseRepository _databaseRepository;
  Future<void> checkBlogSavedOrNot(String bid, String uid) async {
    bool isBlogSaved = await _databaseRepository.isBlogSaved(bid, uid);
    log(isBlogSaved.toString());
    if(isBlogSaved) {
      emit(BlogIsSaved());
    }
  }
  Future<void> saveBlog(String bid, String uid, bool flag) async {
    await _databaseRepository.saveBlog(bid, uid, flag);
    emit(SaveTheBlogPressed());
  }
}
