import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';

class SeriesDTO extends Series {
  SeriesDTO({
    required super.id,
    required super.name,
    super.genres,
    super.time,
    super.days,
    super.summary,
    super.image,
    super.episodes,
  });

  factory SeriesDTO.fromJson(Map<String, dynamic> json) => SeriesDTO(
      id: json['id'],
      name: json['name'],
      image: json['image'] != null ? json['image']['medium'] : null,
      genres: List<String>.from(json['genres']),
      time: json['schedule']['time'],
      days: List<String>.from(json['schedule']['days']),
      summary: json['summary']);
}
