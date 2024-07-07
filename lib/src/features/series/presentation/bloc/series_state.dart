import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

enum SeriesStatus { initial, success, failure }

// ignore: must_be_immutable
final class SeriesState extends Equatable {
  final SeriesStatus status;
  final List<Series> seriesList;
  final bool hasReachedMax;
  final int pageIndex;
  late Series? series;

  SeriesState({
    this.status = SeriesStatus.initial,
    this.seriesList = const <Series>[],
    this.hasReachedMax = false,
    this.pageIndex = 0,
    this.series,
  });

  SeriesState copyWith({
    SeriesStatus? status,
    List<Series>? seriesList,
    bool? hasReachedMax,
    int? pageIndex,
    Series? series,
  }) =>
      SeriesState(
          status: status ?? this.status,
          seriesList: seriesList ?? this.seriesList,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          pageIndex: pageIndex ?? this.pageIndex,
          series: series ?? this.series);

  @override
  String toString() {
    return '''SeriesState {status: $status, seriesList: ${seriesList.length}}, hasReachedMax: $hasReachedMax, pageIndex: $pageIndex, series: ${series.toString()}''';
  }

  @override
  List<Object?> get props =>
      [status, seriesList, hasReachedMax, pageIndex, series];
}
