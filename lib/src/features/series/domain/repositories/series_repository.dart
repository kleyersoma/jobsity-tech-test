import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

abstract class SeriesRepository {
  Future<List<Series>> listAllSeries({required int pageIndex});
  Future<Series> seriesInformation({required int id});
  Future<Map<int, List<Episode>>> listSeriesEpisodes({required int showId});
}
