import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/sample_feature/sample_item_details_view.dart';
import 'package:flutter_tech_assignment/src/features/sample_feature/sample_item_list_view.dart';

class AppRouter {
  final RouteSettings _routeSettings;

  AppRouter(this._routeSettings);

  MaterialPageRoute get appRouter => MaterialPageRoute<void>(
        settings: _routeSettings,
        builder: (BuildContext context) {
          switch (_routeSettings.name) {
            case SampleItemDetailsView.routeName:
              return const SampleItemDetailsView();
            case SampleItemListView.routeName:
            default:
              return const SampleItemListView();
          }
        },
      );
}
