import 'dart:convert' as convert;
import 'package:sns_answer/models/album.dart';
import 'package:http/http.dart' as http;

const url = 'https://jsonplaceholder.typicode.com';

Future<List<Album>> getAlbumList() async {
  final response = await http.get(
    Uri.parse('$url/albums'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> albumData = convert.jsonDecode(response.body);
    final albumList = albumData.map((e) => Album.fromJson(e)).toList();
    return Future<List<Album>>.value(albumList);
  } else {
    throw Exception('Failed to fetch data');
  }
}
