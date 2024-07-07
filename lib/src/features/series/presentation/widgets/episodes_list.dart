import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/episodes.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/episode_view.dart';
import 'package:gap/gap.dart';

class EpisodesList extends StatefulWidget {
  const EpisodesList({super.key, required this.episodes});
  final Map<int, List<Episode>>? episodes;
  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  @override
  Widget build(BuildContext context) {
    return widget.episodes != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.episodes!.entries.map<Widget>(
              (mapEntry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Season ${mapEntry.key}'),
                    const Gap(12),
                    SizedBox(
                      height: 172,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final episode = mapEntry.value.elementAt(index);
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, EpisodeView.routeName,
                                arguments: episode),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                episode.image != null
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CachedNetworkImage(
                                            imageUrl: episode.image!,
                                            height: 148,
                                            width: 148 * 0.75,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      )
                                    : const Icon(Icons.movie),
                                const Gap(6),
                                Text(
                                  episode.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(12),
                              ],
                            ),
                          );
                        },
                        itemCount: mapEntry.value.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                );
              },
            ).toList(),
          )
        : const Center(
            child: Text('There are no episodes yet!'),
          );
  }
}
