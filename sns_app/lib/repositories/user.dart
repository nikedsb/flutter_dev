import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sns_app/models/user.dart';
import 'package:sns_app/repositories/error.dart';

Future<List<User>> fetchUsers() async {
  Uri url = Uri.https("jsonplaceholder.typicode.com", "/users");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    throw ErrorResponseException(
        message: "Could not fetch users", code: res.statusCode, body: res.body);
  }

  List body = jsonDecode(res.body);
  List<User> users = [];
  for (Map<String, Object?> userInfo in body) {
    User user = User.fromJson(userInfo);
    users.add(user);
  }
  return users;
}
