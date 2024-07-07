import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

enum SeriesStatus { initial, success, failure }

final class SeriesState extends Equatable {
  final SeriesStatus status;
  final List<Series> series;
  final bool hasReachedMax;
  final int pageIndex;

  const SeriesState(
      {this.status = SeriesStatus.initial,
      this.series = const <Series>[],
      this.hasReachedMax = false,
      this.pageIndex = 1});

  SeriesState copyWith({
    SeriesStatus? status,
    List<Series>? series,
    bool? hasReachedMax,
    int? pageIndex,
  }) =>
      SeriesState(
          status: status ?? this.status,
          series: series ?? this.series,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          pageIndex: pageIndex ?? this.pageIndex);

  @override
  String toString() {
    return '''SeriesState {status: $status, series: ${series.length}}, hasReachedMax: $hasReachedMax, pageIndex: $pageIndex''';
  }

  @override
  List<Object?> get props => [status, series, hasReachedMax, pageIndex];
}
