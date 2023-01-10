import 'package:sns_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:sns_app/repositories/error.dart';
import 'dart:convert';

Future<List<Post>> fetchPosts() async {
  Uri url = Uri.https("jsonplaceholder.typicode.com", "/posts");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    throw ErrorResponseException(
        message: "Could not fetch posts", code: res.statusCode, body: res.body);
  }

  List body = jsonDecode(res.body);
  List<Post> posts = [];
  for (Map<String, Object?> postInfo in body) {
    Post post = Post.fromJson(postInfo);
    posts.add(post);
  }
  return posts;
}
