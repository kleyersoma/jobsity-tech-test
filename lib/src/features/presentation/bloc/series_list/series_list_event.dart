import 'package:equatable/equatable.dart';

sealed class SeriesListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SeriesListFetched extends SeriesListEvent {}
