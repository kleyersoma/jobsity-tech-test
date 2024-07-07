import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';
import 'package:gap/gap.dart';

class EpisodeView extends StatelessWidget {
  const EpisodeView({super.key});
  static const String routeName = '/episode-view';
  @override
  Widget build(BuildContext context) {
    final episode = ModalRoute.of(context)?.settings.arguments as Episode;
    return Scaffold(
        appBar: AppBar(
          title: Text(episode.name),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                alignment: Alignment.center,
                child: episode.image != null
                    ? CachedNetworkImage(
                        imageUrl: episode.image!,
                        height: 175,
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(
                        width: 75,
                        height: 100,
                        child: Icon(Icons.movie),
                      ),
              ),
              const Gap(12),
              Align(child: Text('S${episode.season}:${episode.number}')),
              const Gap(12),
              Text(episode.summary != null
                  ? '${episode.summary}'
                  : 'No summary available'),
            ])));
  }
}
