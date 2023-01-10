import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/models/album.dart';
import 'package:sns_answer/repositories/album.dart';
import 'package:sns_answer/repositories/picture.dart';
import 'package:sns_answer/repositories/common.dart';

final albumListProvider = FutureProvider<List<Album>>(
  (ref) async {
    return await getAlbumList();
  },
);

final backImgProvider = ChangeNotifierProvider.family<BackImgNotifier, int>(
  (ref, albumId) {
    return BackImgNotifier(albumId: albumId);
  },
);

class BackImgNotifier extends ChangeNotifier {
  final int albumId;
  String imgUrl = '';

  BackImgNotifier({
    required this.albumId,
  });

  Future getBackImg() async {
    final backImg = await getPictureList(albumId: albumId);
    imgUrl = backImg[0].thumbnailUrl;
    notifyListeners();
  }
}

final favoriteAlbumsProvider = ChangeNotifierProvider<FavoriteAlbumNotifier>(
    (ref) => FavoriteAlbumNotifier());

class FavoriteAlbumNotifier extends ChangeNotifier {
  List<Album> favoriteList = [];

  Future getFavoriteAlbumList() async {
    final allAlbums = await getAlbumList();
    favoriteList = [];
    await Future.forEach(allAlbums, (Album item) async {
      final isFavorite = await getFavorite('album', item.id);
      if (isFavorite) {
        favoriteList.add(item);
      }
    });
    notifyListeners();
  }

  void removeMyPageFavorite(int id) {
    final removedItem = favoriteList.firstWhere((element) => element.id == id);
    favoriteList.remove(removedItem);
    notifyListeners();
  }
}
