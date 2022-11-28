// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseFetched extends DatabaseEvent {
  final String? displayName;
  const DatabaseFetched(this.displayName);
  @override
  List<Object?> get props => [displayName];
}

class CreatingBlog extends DatabaseEvent {
  final String title;
  final String content;
  final String? displayName;
  const CreatingBlog({
    required this.title,
    required this.content,
    this.displayName
  });
  @override
  List<Object?> get props => [title, content, displayName];
}
