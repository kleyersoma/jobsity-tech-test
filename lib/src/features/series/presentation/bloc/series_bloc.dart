import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/use_cases/list_all_series.dart';
import 'package:flutter_tech_assignment/src/utils/transformers/throttle_droppable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  SeriesBloc({required this.httpClient}) : super(const SeriesState()) {
    on<SeriesFetched>(_onSeriesFetched,
        transformer: throttleDroppable(throttleDuration));
  }
  final http.Client httpClient;

  Future<void> _onSeriesFetched(
      SeriesFetched event, Emitter<SeriesState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == SeriesStatus.initial) {
        final series =
            await ListAllSeries().execute(pageIndex: state.pageIndex);
        return emit(state.copyWith(
            status: SeriesStatus.success,
            series: series,
            hasReachedMax: false,
            pageIndex: (state.pageIndex) + 1));
      }
      final series = await ListAllSeries().execute(pageIndex: state.pageIndex);
      series.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: SeriesStatus.success,
              series: List.of(state.series)..addAll(series),
              hasReachedMax: false,
              pageIndex: (state.pageIndex) + 1));
    } catch (e) {
      emit(state.copyWith(status: SeriesStatus.failure));
    }
  }
}
