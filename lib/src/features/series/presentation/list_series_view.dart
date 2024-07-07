import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_state.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/bottom_loader.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/series_tile.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_bloc.dart';

class ListSeriesView extends StatelessWidget {
  const ListSeriesView({super.key});

  static const String routeName = '/series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TV Maze API Series'),
        ),
        body: BlocProvider(
          create: (context) =>
              SeriesBloc(httpClient: http.Client())..add(SeriesFetched()),
          child: SeriesBody(),
        ));
  }
}

class SeriesBody extends StatefulWidget {
  const SeriesBody({super.key});

  @override
  State<SeriesBody> createState() => _SeriesBodyState();
}

class _SeriesBodyState extends State<SeriesBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<SeriesBloc>().add(SeriesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesBloc, SeriesState>(builder: (context, state) {
      switch (state.status) {
        case SeriesStatus.initial:
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        case SeriesStatus.success:
          if (state.series.isEmpty) {
            return const Center(
              child: Text('No series to display'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.series.length
                  ? const BottomLoader()
                  : SeriesTile(series: state.series.elementAt(index));
            },
            itemCount: state.hasReachedMax
                ? state.series.length
                : state.series.length + 1,
            controller: _scrollController,
          );
        case SeriesStatus.failure:
          return const Center(
            child: Text('Failed to fetch posts'),
          );
      }
    });
  }
}
