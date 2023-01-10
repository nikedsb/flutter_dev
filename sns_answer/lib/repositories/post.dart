import 'dart:convert' as convert;
import 'package:sns_answer/models/post.dart';
import 'package:http/http.dart' as http;

const url = 'https://jsonplaceholder.typicode.com';

// JSONPlaceholder の投稿データを取得
Future<List<Post>> getPostList() async {
  final response = await http.get(
    Uri.parse('$url/posts'),
  );

  if (response.statusCode == 200) {
    // レスポンスの中身（response.body）を Dart オブジェクトに変換
    final List<dynamic> postData = convert.jsonDecode(response.body);
    // freezed で生成された fromJson() メソッドを呼び出して Post クラスのインスタンスを作成
    // ここでは postData がリスト形式なので、fromJson() の後に toList() が必要
    final postList = postData.map((e) => Post.fromJson(e)).toList();
    return Future<List<Post>>.value(postList);
  } else {
    throw Exception('Failed to fetch data');
  }
}
