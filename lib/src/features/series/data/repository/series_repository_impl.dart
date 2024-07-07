import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_tech_assignment/src/features/series/data/dtos/serie_dto.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/repositories/series_repository.dart';
import 'package:flutter_tech_assignment/src/utils/endpoints/tv_maze_api_endpoints.dart';
import 'package:http/http.dart' as http;

class SeriesRepositoryImpl implements SeriesRepository {
  const SeriesRepositoryImpl();
  @override
  Future<List<Series>> listAllSeries({required int pageIndex}) async {
    try {
      final response = await http
          .get(Uri.parse(TVMazeAPIEndPoints.showIndex(pageIndex: pageIndex)));
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Series> seriesList =
            jsonList.map((json) => SerieDTO.fromJson(json)).toList();
        return seriesList;
      } 
      else {
        throw Exception('Failed to get series list from TV Maze API');
      }
    } catch (e) {
      log(e.toString(), error: e);
      throw Exception('Error fetching series: $e');
    }
  }

  @override
  Future<List<Episode>> listAllSeriesEpisodes({required int id}) {
    // TODO: implement listAllSeriesEpisodes
    throw UnimplementedError();
  }

  @override
  Future<Series> seriesInformation({required int id}) {
    // TODO: implement seriesInformation
    throw UnimplementedError();
  }
}
