
import 'package:equatable/equatable.dart';

sealed class SeriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SeriesFetched extends SeriesEvent {}
