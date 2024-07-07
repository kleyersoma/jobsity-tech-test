import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

class SerieDTO extends Series {
  SerieDTO({
    required super.id,
    required super.name,
    required super.genres,
    required super.time,
    required super.days,
    required super.summary,
    super.image,
    super.episodes,
  });

  factory SerieDTO.fromJson(Map<String, dynamic> json) => SerieDTO(
      id: json['id'],
      name: json['name'],
      image: json['image']['medium'],
      genres: List<String>.from(json['genres']),
      time: json['schedule']['time'],
      days: List<String>.from(json['schedule']['days']),
      summary: json['summary']);
}
