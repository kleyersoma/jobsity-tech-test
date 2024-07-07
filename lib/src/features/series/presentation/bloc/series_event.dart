import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

sealed class SeriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SeriesFetched extends SeriesEvent {}

final class SeriesEpisodesFetched extends SeriesEvent {
  final Series series;

  SeriesEpisodesFetched({required this.series});
}
