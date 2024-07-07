import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';

class EpisodeDTO extends Episode {
  EpisodeDTO(
      {required super.id,
      required super.name,
      required super.season,
      required super.number,
      required super.summary,
      super.image});

  factory EpisodeDTO.fromJson(Map<String, dynamic> json) {
    return EpisodeDTO(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      number: json['number'],
      image: json['image']['medium'],
      summary: json['summary'],
    );
  }
}
