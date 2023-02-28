import 'package:bloc/bloc.dart';
import 'package:blogit/models/blog_model.dart';
import 'package:blogit/repositories/database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DatabaseRepository _dbRepo;
  SearchBloc(this._dbRepo) : super(SearchInitial()) {
    on<SearchQueryEntered>(_fetchBlogsBasedOnQuery);
  }

  _fetchBlogsBasedOnQuery(SearchQueryEntered event, Emitter<SearchState> emit) async {
    if(event.query != null){
      String query = event.query!;
      List<BlogModel> listBasedOnSearch = await _dbRepo.listBasedOnSearch(query);
      emit(SearchSuccess(listBasedOnSearch));
    }
    if(event.query == "") {
      emit(SearchInitial());
    }
  }
}
