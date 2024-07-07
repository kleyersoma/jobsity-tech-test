import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';

class EpisodeView extends StatelessWidget {
  const EpisodeView({super.key});
  static const String routeName = '/episode-view';
  @override
  Widget build(BuildContext context) {
    final episode = ModalRoute.of(context)?.settings.arguments as Episode;
    return const Placeholder();
  }
}
