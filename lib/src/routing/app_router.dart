import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/presentation/episode_view.dart';
import 'package:flutter_tech_assignment/src/features/presentation/series_list_view.dart';
import 'package:flutter_tech_assignment/src/features/presentation/series_view.dart';

class AppRouter {
  final RouteSettings _routeSettings;

  AppRouter(this._routeSettings);

  MaterialPageRoute get appRouter => MaterialPageRoute<void>(
        settings: _routeSettings,
        builder: (BuildContext context) {
          switch (_routeSettings.name) {
            case SeriesListView.routeName:
              return const SeriesListView();
            case SeriesView.routeName:
              return const SeriesView();
            case EpisodeView.routeName:
              return const EpisodeView();
            default:
              return const SeriesListView();
          }
        },
      );
}
