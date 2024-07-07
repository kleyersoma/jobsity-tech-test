import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/use_cases/list_all_series.dart';
import 'package:flutter_tech_assignment/src/utils/transformers/throttle_droppable.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_list/series_list_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_list/series_list_state.dart';

class SeriesListBloc extends Bloc<SeriesListEvent, SeriesListState> {
  ScrollController scrollController = ScrollController();

  SeriesListBloc() : super(const SeriesListState()) {
    on<SeriesListFetched>(_onSeriesFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onSeriesFetched(
      SeriesListFetched event, Emitter<SeriesListState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == SeriesListStatus.initial) {
        final series =
            await ListAllSeries().execute(pageIndex: state.pageIndex);
        return emit(state.copyWith(
            status: SeriesListStatus.success,
            seriesList: series,
            hasReachedMax: false,
            pageIndex: (state.pageIndex) + 1));
      }
      final series = await ListAllSeries().execute(pageIndex: state.pageIndex);
      series.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: SeriesListStatus.success,
              seriesList: List.of(state.seriesList)..addAll(series),
              hasReachedMax: false,
              pageIndex: (state.pageIndex) + 1));
    } catch (e) {
      emit(state.copyWith(status: SeriesListStatus.failure));
    }
  }

  void onScroll(BuildContext context) {
    if (_isBottom) context.read<SeriesListBloc>().add(SeriesListFetched());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
