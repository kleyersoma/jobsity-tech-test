class Episode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String? summary;
  late String? image;

  Episode(
      {required this.id,
      required this.name,
      required this.season,
      required this.number,
      this.summary,
      this.image});
}
