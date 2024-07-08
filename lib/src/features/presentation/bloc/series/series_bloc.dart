import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';
import 'package:flutter_tech_assignment/src/features/domain/use_cases/list_series_episodes.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/series/series_event.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/series/series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  SeriesBloc({required Series series}) : super(SeriesState(series: series)) {
    on<SeriesEpisodesFetched>(_onSeriesEpisodesFetched);
  }

  Future<void> _onSeriesEpisodesFetched(
      SeriesEpisodesFetched event, Emitter<SeriesState> emit) async {
    try {
      if (state.status == SeriesStatus.loading) {
        final seriesEpisodes =
            await ListSeriesEpisodes().execute(showId: state.series.id);
        state.series.episodes = seriesEpisodes;
        return emit(
            state.copyWith(status: SeriesStatus.success, series: state.series));
      }
    } catch (e) {
      emit(state.copyWith(status: SeriesStatus.failure));
    }
  }
}
