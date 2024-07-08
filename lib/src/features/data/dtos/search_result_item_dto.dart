import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';

class SearchResultItemDto extends SearchResultItem {
  SearchResultItemDto(
      {required super.id,
      required super.name,
      required super.genres,
      super.image});
}
