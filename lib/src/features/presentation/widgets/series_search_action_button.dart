import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_tech_assignment/src/features/presentation/widgets/search_series_delegate.dart';

class SeriesSearchActionButton extends StatelessWidget {
  const SeriesSearchActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async => await showSearch<Series?>(
            context: context,
            delegate: SearchSeriesDelegate(
                searchBloc: BlocProvider.of<SearchBloc>(context))),
        icon: const Icon(Icons.search));
  }
}
