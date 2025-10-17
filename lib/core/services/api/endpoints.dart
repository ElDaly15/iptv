// ignore_for_file: file_names
abstract class Endpoints {
  static const String baseUrl = 'https://api.beeplayer1.com/';
  static const String login = 'auth/customer/login';
  static String getIptvCategories(String playlistId) => "customers/iptv/categories?playlist_id=$playlistId";
  static String getIptvChannels(String categoryId, String playlistId) => "customers/iptv/channels?category_id=$categoryId&playlist_id=$playlistId";
  static String getMovieCategories(String playlistId) => "customers/iptv/vod/categories?playlist_id=$playlistId";
}
