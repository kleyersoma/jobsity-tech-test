class TVMazeAPIEndPoints {
  static const String baseUrl = 'https://api.tvmaze.com';
  static String showIndex({required int pageIndex}) =>
      '$baseUrl/shows?page=$pageIndex';
  static String showEpisodesList({required int showId}) =>
      '$baseUrl/shows/$showId/episodes';
  static String showSearch({required String query}) =>
      '$baseUrl/search/shows?q=$query';
}
