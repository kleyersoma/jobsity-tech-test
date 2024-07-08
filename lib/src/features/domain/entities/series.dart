import 'package:flutter_tech_assignment/src/features/domain/entities/episodes.dart';

class Series {
  final int id;
  final String name;
  final String? image;
  final List<String>? genres;
  final String? time;
  final List<String>? days;
  final String? summary;
  Map<int, List<Episode>>? episodes;

  Series({
    required this.id,
    required this.name,
    this.genres,
    this.time,
    this.days,
    this.summary,
    this.image,
    this.episodes,
  });
}
