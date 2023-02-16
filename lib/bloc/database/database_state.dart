part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
  
  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final List<UserModel> listOfUserData;
  final List<BlogModel> listOfBlogs;
  final String? displayName;
  const DatabaseSuccess(this.listOfUserData,this.listOfBlogs,this.displayName);

    @override
  List<Object?> get props => [listOfUserData,displayName];
}

class SavedDatabaseSuccess extends DatabaseState {
  final List<BlogModel> listOfSavedBlogs;
  const SavedDatabaseSuccess(this.listOfSavedBlogs);

    @override
  List<Object?> get props => [listOfSavedBlogs];
}

class BlogAddedToDatabase extends DatabaseState {
      @override
  List<Object?> get props => [];
}

// class SavedTheBlog extends DatabaseState {
//       @override
//   List<Object?> get props => [];
// }

class DatabaseError extends DatabaseState {
      @override
  List<Object?> get props => [];
}