import 'package:flutter_tech_assignment/src/features/series/data/repository/series_repository_impl.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/repositories/series_repository.dart';

class ListAllSeries {
  final SeriesRepository _seriesRepository;

  ListAllSeries(
      {SeriesRepository seriesRepository = const SeriesRepositoryImpl()})
      : _seriesRepository = seriesRepository;

  Future<List<Series>> execute({required int pageIndex}) async =>
      _seriesRepository.listAllSeries(pageIndex: pageIndex);
}
