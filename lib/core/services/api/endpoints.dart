// ignore_for_file: file_names
abstract class Endpoints {
  static const String baseUrl = 'https://api.beeplayer1.com/';
  static const String login = 'auth/customer/login';
  static String getIptvCategories(String playlistId) => "customers/iptv/categories?playlist_id=$playlistId";
}
