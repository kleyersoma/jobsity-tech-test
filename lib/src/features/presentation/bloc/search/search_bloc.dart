import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_tech_assignment/src/features/domain/use_cases/series_search.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_event.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_state.dart';
import 'package:flutter_tech_assignment/src/utils/exceptions/search_result_error.dart';
import 'package:flutter_tech_assignment/src/utils/transformers/debounce.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchStateEmpty()) {
    on<SearchTextChanged>(_onTextChanged,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<SearchLeave>(_onSearchLeave);
  }

  Future<void> _onTextChanged(
    SearchTextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final searchResults = await SeriesSearch().execute(query: searchTerm);
      emit(SearchStateSuccess(searchResults));
    } catch (error) {
      emit(
        error is SearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('Something went wrong'),
      );
    }
  }

  Future<void> _onSearchLeave(
    SearchLeave event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchStateEmpty());
    } catch (error) {
      emit(
        error is SearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('Something went wrong'),
      );
    }
  }
}
