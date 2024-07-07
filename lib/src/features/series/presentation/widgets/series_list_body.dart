import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_list/series_list_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_list/series_list_state.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/bottom_loader.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/series_tile.dart';

class SeriesListBody extends StatefulWidget {
  const SeriesListBody({super.key});

  @override
  State<SeriesListBody> createState() => _SeriesListBodyState();
}

class _SeriesListBodyState extends State<SeriesListBody> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesListBloc>().scrollController.addListener(
          () => context.read<SeriesListBloc>().onScroll(context),
        );
  }

  @override
  void dispose() {
    context.read<SeriesListBloc>().scrollController
      ..removeListener(
        () => context.read<SeriesListBloc>().onScroll(context),
      )
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesListBloc, SeriesListState>(
        builder: (context, state) {
      switch (state.status) {
        case SeriesListStatus.initial:
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        case SeriesListStatus.success:
          if (state.seriesList.isEmpty) {
            return const Center(
              child: Text('No series to display'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.seriesList.length
                  ? const BottomLoader()
                  : SeriesTile(series: state.seriesList.elementAt(index));
            },
            itemCount: state.hasReachedMax
                ? state.seriesList.length
                : state.seriesList.length + 1,
            controller: context.read<SeriesListBloc>().scrollController,
          );
        case SeriesListStatus.failure:
          return const Center(
            child: Text('Failed to fetch series'),
          );
      }
    });
  }
}
