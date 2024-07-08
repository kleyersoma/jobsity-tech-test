import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';

class SearchResultItemDto extends SearchResultItem {
  SearchResultItemDto({
    required super.id,
    required super.name,
    required super.genres,
    super.time,
    super.days,
    super.summary,
    super.image,
    super.episodes,
  });

  factory SearchResultItemDto.fromJson(Map<String, dynamic> json) {
    json = json['show'];
    return SearchResultItemDto(
      id: json['id'],
      name: json['name'],
      genres: List<String>.from(json['genres']),
      time: json['schedule']['time'],
      days: List<String>.from(json['schedule']['days']),
      summary: json['summary'],
      image: json['image'] != null ? json['image']['medium'] : null,
    );
  }
}
