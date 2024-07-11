import 'package:equatable/equatable.dart';

import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchStateEmpty extends SearchState {}

final class SearchStateLoading extends SearchState {}

final class SearchStateSuccess extends SearchState {
  const SearchStateSuccess(this.searchResultsItems);

  final List<SearchResultItem> searchResultsItems;
  @override
  List<Object> get props => [searchResultsItems];

  @override
  String toString() =>
      'SearchStateSuccess { searchResultItems: ${searchResultsItems.length} }';
}

final class SearchStateError extends SearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
