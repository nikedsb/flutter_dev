import 'dart:convert' as convert;
import 'package:sns_answer/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const url = 'https://jsonplaceholder.typicode.com';

Future<List<User>> getUsers() async {
  final response = await http.get(Uri.parse("$url/users"));
  if (response.statusCode == 200) {
    final List<dynamic> userData = convert.jsonDecode(response.body);
    final userList =
        userData.map((e) => User.fromJson(e)).toList(); //リスト内包みたいな書き方ができる
    return Future<List<User>>.value(
        userList); //この書き方知らない→Future.valueコンストラクタ＝要するにただFuture型に変換してるだけ
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<String> getUsername() async {
  final data = await SharedPreferences.getInstance();
  final username = data.getString('username');
  // 未設定の場合は username が null
  // username が null なら 'ゲスト' と返す
  return username == null ? Future.value('ゲスト') : Future.value(username);
}

void setUsername(String newUsername) async {
  final data = await SharedPreferences.getInstance();
  data.setString('username', newUsername);
}
