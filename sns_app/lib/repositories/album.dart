import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/models/album.dart';
import 'package:sns_app/repositories/error.dart';
import 'package:sns_app/repositories/album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchAlbums() async {
  Uri url = Uri.https("jsonplaceholder.typicode.com", "/albums");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    throw ErrorResponseException(
        message: "Could not fetch albums",
        code: res.statusCode,
        body: res.body);
  }

  List body = jsonDecode(res.body);
  List<Album> albums = [];
  for (Map<String, Object?> albumInfo in body) {
    Album album = Album.fromJson(albumInfo);
    albums.add(album);
  }
  return albums;
}
