import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


Future<void> saveToken(String token) async {
  await storage.write(key: 'token', value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: 'token');
}

Future<void> deleteToken() async {
  await storage.delete(key: 'token');
}


Future<String?> getPlaylistId() async {
  return await storage.read(key: 'playlist_id');
}

Future<void> savePlaylistId(String playlistId) async {
  await storage.write(key: 'playlist_id', value: playlistId);
}

Future<void> deletePlaylistId() async {
  await storage.delete(key: 'playlist_id');
}