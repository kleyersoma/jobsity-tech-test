import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/series_list_body.dart';

import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_bloc.dart';

class SeriesListView extends StatelessWidget {
  const SeriesListView({super.key});

  static const String routeName = '/series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TV Maze API Series'),
        ),
        body: BlocProvider(
          create: (context) => SeriesBloc()..add(SeriesFetched()),
          child: const SeriesListBody(),
        ));
  }
}
