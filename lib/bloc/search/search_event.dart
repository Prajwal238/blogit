part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEntered extends SearchEvent {
  final String? query;
  const SearchQueryEntered(this.query);

  @override
  List<Object?> get props => [query];
}