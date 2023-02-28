part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchSuccess extends SearchState {
  final List<BlogModel> listBasedOnSearch;
  const SearchSuccess(this.listBasedOnSearch);
  
  @override
  List<Object?> get props => [listBasedOnSearch];
}
