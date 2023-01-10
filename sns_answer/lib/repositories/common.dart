import 'package:shared_preferences/shared_preferences.dart';
// キーバリューストアから出てくるものを取り出す処理を書く

Future<bool> getFavorite(String type, int id) async {
  final data = await SharedPreferences.getInstance();
  final isFavorite = data.getBool("$type$id");
  return isFavorite == null ? Future.value(false) : Future.value(isFavorite);
}

void setFavorite(String type, int id, {bool isFavorite = false}) async {
  final data = await SharedPreferences.getInstance();
  await data.setBool("$type$id", !isFavorite);
}
