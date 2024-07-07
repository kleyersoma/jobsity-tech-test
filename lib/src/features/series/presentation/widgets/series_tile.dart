import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_assignment/src/features/series/domain/entities/serie.dart';

class SeriesTile extends StatelessWidget {
  const SeriesTile({super.key, required this.series});
  final Series series;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: series.image == null
          ? const Icon(Icons.movie)
          : CachedNetworkImage(
              imageUrl: series.image!,
              width: 50,
              height: 75,
              fit: BoxFit.contain,
            ),
      title: Text(series.name),
      subtitle: Text(series.genres.join(', ')),
      isThreeLine: true,
    );
  }
}
