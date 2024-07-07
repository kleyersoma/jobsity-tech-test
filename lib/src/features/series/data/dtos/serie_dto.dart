import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

class SerieDTO extends Series {
  SerieDTO({
    required super.id,
    required super.name,
    super.genres,
    super.time,
    super.days,
    super.summary,
    super.image,
    super.episodes,
  });

  factory SerieDTO.fromJson(Map<String, dynamic> json) => SerieDTO(
      id: json['id'],
      name: json['name'],
      image: json['image'] != null ? json['image']['medium'] : null,
      genres: List<String>.from(json['genres']),
      time: json['schedule']['time'],
      days: List<String>.from(json['schedule']['days']),
      summary: json['summary']);
}
