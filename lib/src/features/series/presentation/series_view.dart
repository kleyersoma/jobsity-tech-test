import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

class SeriesView extends StatelessWidget {
  const SeriesView({super.key});
  static const String routeName = '/series-view';
  @override
  Widget build(BuildContext context) {
    final series = ModalRoute.of(context)?.settings.arguments as Series;
    return const Placeholder();
  }
}
