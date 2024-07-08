import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tech_assignment/src/features/data/dtos/search_result_item_dto.dart';
import 'package:flutter_tech_assignment/src/utils/exceptions/search_result_error.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_assignment/src/features/domain/entities/search_result_item.dart';
import 'package:flutter_tech_assignment/src/features/domain/repository/search_repository.dart';
import 'package:flutter_tech_assignment/src/utils/endpoints/tv_maze_api_endpoints.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl();

  @override
  Future<List<SearchResultItem>> searchShow({required String query}) async {
    try {
      final response = await http
          .get(Uri.parse(TVMazeAPIEndPoints.showSearch(query: query)));

      if (response.statusCode == HttpStatus.ok) {
        return compute(_parseSearchResult, response.body);
      } else {
        throw SearchResultError(
            message: 'Failed to get series list from TV Maze API');
      }
    } on SearchResultError {
      return <SearchResultItem>[];
    } catch (e) {
      log(e.toString(), error: e);
      return <SearchResultItem>[];
    }
  }

  List<SearchResultItem> _parseSearchResult(String responseBody) {
    final jsonParsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    List<SearchResultItem> searchResultList = jsonParsed
        .map<SearchResultItem>((json) => SearchResultItemDto.fromJson(json))
        .toList();
    return searchResultList;
  }
}
