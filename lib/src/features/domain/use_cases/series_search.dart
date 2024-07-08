import 'package:flutter_tech_assignment/src/features/data/repository/search_repository_impl.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';
import 'package:flutter_tech_assignment/src/features/domain/repository/search_repository.dart';

class SeriesSearch {
  final SearchRepository _searchRepository;

  SeriesSearch({SearchRepository searchRepository = const SearchRepositoryImpl()})
      : _searchRepository = searchRepository;

  Future<List<SearchResultItem>> execute({required String query}) async {
    return _searchRepository.searchShow(query: query);
  }
}
