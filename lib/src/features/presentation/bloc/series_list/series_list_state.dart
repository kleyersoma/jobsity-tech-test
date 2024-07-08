import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';

enum SeriesListStatus { initial, success, failure }

final class SeriesListState extends Equatable {
  final SeriesListStatus status;
  final List<Series> seriesList;
  final bool hasReachedMax;
  final int pageIndex;

  const SeriesListState({
    this.status = SeriesListStatus.initial,
    this.seriesList = const <Series>[],
    this.hasReachedMax = false,
    this.pageIndex = 0,
  });

  SeriesListState copyWith({
    SeriesListStatus? status,
    List<Series>? seriesList,
    bool? hasReachedMax,
    int? pageIndex,
  }) =>
      SeriesListState(
        status: status ?? this.status,
        seriesList: seriesList ?? this.seriesList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageIndex: pageIndex ?? this.pageIndex,
      );

  @override
  String toString() {
    return '''SeriesListState {status: $status, seriesList: ${seriesList.length}}, hasReachedMax: $hasReachedMax, pageIndex: $pageIndex''';
  }

  @override
  List<Object?> get props => [status, seriesList, hasReachedMax, pageIndex];
}
