import 'package:equatable/equatable.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';

enum SeriesStatus { loading, success, failure }

final class SeriesState extends Equatable {
  final SeriesStatus status;
  final Series series;

  const SeriesState({
    this.status = SeriesStatus.loading,
    required this.series,
  });

  SeriesState copyWith({
    SeriesStatus? status,
    Series? series,
  }) =>
      SeriesState(status: status ?? this.status, series: series ?? this.series);

  @override
  String toString() {
    return '''SeriesState {status: $status, series: ${series.toString()}''';
  }

  @override
  List<Object?> get props => [status, series];
}
