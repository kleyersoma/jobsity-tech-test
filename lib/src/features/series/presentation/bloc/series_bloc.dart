import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/use_cases/list_all_series.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/use_cases/list_series_episodes.dart';
import 'package:flutter_tech_assignment/src/utils/transformers/throttle_droppable.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  ScrollController scrollController = ScrollController();

  SeriesBloc() : super(SeriesState()) {
    on<SeriesFetched>(_onSeriesFetched,
        transformer: throttleDroppable(throttleDuration));
    on<SeriesEpisodesFetched>(_onSeriesEpisodesFetched);
  }

  Future<void> _onSeriesFetched(
      SeriesFetched event, Emitter<SeriesState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == SeriesStatus.initial) {
        final series =
            await ListAllSeries().execute(pageIndex: state.pageIndex);
        return emit(state.copyWith(
            status: SeriesStatus.success,
            seriesList: series,
            hasReachedMax: false,
            pageIndex: (state.pageIndex) + 1));
      }
      final series = await ListAllSeries().execute(pageIndex: state.pageIndex);
      series.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: SeriesStatus.success,
              seriesList: List.of(state.seriesList)..addAll(series),
              hasReachedMax: false,
              pageIndex: (state.pageIndex) + 1));
    } catch (e) {
      emit(state.copyWith(status: SeriesStatus.failure));
    }
  }

  Future<void> _onSeriesEpisodesFetched(
      SeriesEpisodesFetched event, Emitter<SeriesState> emit) async {
    try {
      if (state.status == SeriesStatus.initial) {
        state.series = event.series;
        final seriesEpisodes =
            await ListSeriesEpisodes().execute(showId: state.series!.id);
        state.series!.episodes = seriesEpisodes;
        return emit(
            state.copyWith(status: SeriesStatus.success, series: state.series));
      }
    } catch (e) {
      emit(state.copyWith(status: SeriesStatus.failure));
    }
  }

  void onScroll(BuildContext context) {
    if (_isBottom) context.read<SeriesBloc>().add(SeriesFetched());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
