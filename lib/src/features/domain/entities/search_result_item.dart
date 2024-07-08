import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';

class SearchResultItem extends Series {
  SearchResultItem({
    required super.id,
    required super.name,
    super.time,
    super.days,
    super.episodes,
    super.genres,
    super.image,
    super.summary,
  });
}
