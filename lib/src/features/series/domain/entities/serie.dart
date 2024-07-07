import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';

class Series with ChangeNotifier {
  final int id;
  final String name;
  final String? image;
  final List<String>? genres;
  final String? time;
  final List<String>? days;
  final String? summary;
  late Map<int, List<Episode>>? episodes;

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

  void updateEpisodes({required Map<int, List<Episode>> e}) {
    episodes = e;
    notifyListeners();
  }
}
