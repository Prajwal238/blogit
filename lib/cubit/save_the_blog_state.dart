part of 'save_the_blog_cubit.dart';

abstract class SaveTheBlogState extends Equatable {
  const SaveTheBlogState();

  @override
  List<Object> get props => [];
}

class SaveTheBlogInitial extends SaveTheBlogState {}

class SaveTheBlogPressed extends SaveTheBlogState {}

class BlogIsSaved extends SaveTheBlogState {}
