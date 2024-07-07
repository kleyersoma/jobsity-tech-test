import 'dart:developer';

import 'package:flutter_tech_assignment/src/features/series/data/repository/series_repository_impl.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/repositories/series_repository.dart';

class ListSeriesEpisodes {
  final SeriesRepository _seriesRepository;

  ListSeriesEpisodes(
      {SeriesRepository seriesRepository = const SeriesRepositoryImpl()})
      : _seriesRepository = seriesRepository;

  Future<Map<int, List<Episode>>> execute({required int showId}) async {
    log('fetching showID $showId episodes');
    return await _seriesRepository.listSeriesEpisodes(showId: showId);
  }
}
