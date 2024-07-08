import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';

abstract class SearchRepository {
  Future<List<SearchResultItem>> searchShow({required String query});
}
