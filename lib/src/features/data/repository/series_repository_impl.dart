import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tech_assignment/src/features/data/dtos/episode_dto.dart';
import 'package:flutter_tech_assignment/src/features/data/dtos/series_dto.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/episodes.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';
import 'package:flutter_tech_assignment/src/features/domain/repository/series_repository.dart';
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
        return compute(_parseSeries, response.body);
      } else {
        throw Exception('Failed to get series list from TV Maze API');
      }
    } catch (e) {
      log(e.toString(), error: e);
      throw Exception('Error fetching series: $e');
    }
  }

  @override
  Future<Map<int, List<Episode>>> listSeriesEpisodes(
      {required int showId}) async {
    try {
      final response = await http
          .get(Uri.parse(TVMazeAPIEndPoints.showEpisodesList(showId: showId)));

      if (response.statusCode == HttpStatus.ok) {
        return compute(_parseSeriesEpisodes, response.body);
      } else {
        throw Exception('Failed to get series list from TV Maze API');
      }
    } catch (e) {
      log(e.toString(), error: e);
      throw Exception('Error fetching series: $e');
    }
  }

  @override
  Future<Series> seriesInformation({required int id}) {
    // TODO: implement seriesInformation
    throw UnimplementedError();
  }

  List<Series> _parseSeries(String responseBody) {
    final jsonParsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    List<Series> seriesList =
        jsonParsed.map<Series>((json) => SeriesDTO.fromJson(json)).toList();
    return seriesList;
  }

  Map<int, List<Episode>> _parseSeriesEpisodes(String responseBody) {
    final jsonParsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    final episodeList =
        jsonParsed.map<Episode>((json) => EpisodeDTO.fromJson(json)).toList();
    final seriesEpisodes = <int, List<Episode>>{};

    for (var element in episodeList) {
      seriesEpisodes.update(
        element.season,
        (episodesList) {
          episodesList.add(element);
          return episodesList;
        },
        ifAbsent: () => <Episode>[element],
      );
    }

    return seriesEpisodes;
  }
}
