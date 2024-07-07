import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series/series_bloc.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series/series_event.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/bloc/series/series_state.dart';
import 'package:flutter_tech_assignment/src/features/series/presentation/widgets/episodes_list.dart';
import 'package:gap/gap.dart';

class SeriesView extends StatelessWidget {
  const SeriesView({super.key});
  static const String routeName = '/series-view';
  @override
  Widget build(BuildContext context) {
    final series = ModalRoute.of(context)?.settings.arguments as Series;
    return Scaffold(
        appBar: AppBar(
          title: Text(series.name),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                alignment: Alignment.center,
                child: series.image != null
                    ? CachedNetworkImage(
                        imageUrl: series.image!,
                        width: 175 * 0.75,
                        height: 175,
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(
                        width: 75,
                        height: 100,
                        child: Icon(Icons.movie),
                      ),
              ),
              const Gap(18),
              Text(series.time != null
                  ? 'Transmited at ${series.time}'
                  : 'Transmited at: No information available'),
              const Gap(12),
              Text(series.days?.isNotEmpty ?? false
                  ? 'Days: ${series.days!.join(",")}'
                  : 'Days: No information available'),
              const Gap(12),
              Text(series.genres?.isNotEmpty ?? false
                  ? 'Genres: ${series.genres!.join(", ")}'
                  : 'Genres: No information available'),
              const Gap(12),
              Text(series.summary != null
                  ? '${series.summary}'
                  : 'No summary available'),
              const Gap(12),
              const Text(
                'Episodes:',
                textAlign: TextAlign.left,
              ),
              const Gap(12),
              BlocBuilder<SeriesBloc, SeriesState>(
                  bloc: SeriesBloc(series: series)
                    ..add(SeriesEpisodesFetched()),
                  builder: (context, state) {
                    switch (state.status) {
                      case SeriesStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case SeriesStatus.success:
                        return EpisodesList(episodes: series.episodes);
                      case SeriesStatus.failure:
                        return const Center(
                          child: Text('Failed to fetch series information!'),
                        );
                    }
                  })
            ])));
  }
}
