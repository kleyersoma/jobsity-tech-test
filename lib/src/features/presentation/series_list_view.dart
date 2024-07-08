import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/presentation/widgets/series_list_body.dart';

import 'package:flutter_tech_assignment/src/features/presentation/widgets/series_search_action_button.dart';

class SeriesListView extends StatelessWidget {
  const SeriesListView({super.key});

  static const String routeName = '/series-index';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TV Maze API Series'),
          actions: const [
            SeriesSearchActionButton(),
          ],
        ),
        body: const SeriesListBody());
  }
}
