import 'package:sns_app/models/picture.dart';
import 'package:sns_app/repositories/error.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchPictures() async {
  Uri url = Uri.https("jsonplaceholder.typicode.com", "/photos");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    throw ErrorResponseException(
        message: "Could not fetch pictures",
        code: res.statusCode,
        body: res.body);
  }

  List body = jsonDecode(res.body);
  List<Picture> pictures = [];
  print(body);
  for (Map<String, Object?> pictureInfo in body) {
    Picture picture = Picture.fromJson(pictureInfo);
    pictures.add(picture);
  }
  return pictures;
}
