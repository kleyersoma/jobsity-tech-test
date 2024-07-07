import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_state.dart';
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
    context.read<SeriesBloc>().scrollController.addListener(
          () => context.read<SeriesBloc>().onScroll(context),
        );
  }

  @override
  void dispose() {
    context.read<SeriesBloc>().scrollController
      ..removeListener(
        () => context.read<SeriesBloc>().onScroll(context),
      )
      ..dispose();
    super.dispose();
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
            controller: context.read<SeriesBloc>().scrollController,
          );
        case SeriesStatus.failure:
          return const Center(
            child: Text('Failed to fetch series'),
          );
      }
    });
  }
}
