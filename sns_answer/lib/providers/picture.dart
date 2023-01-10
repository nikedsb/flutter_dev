import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/models/picture.dart';
import 'package:sns_answer/repositories/picture.dart';
import 'package:sns_answer/repositories/common.dart';

final pictureProvider = FutureProvider.family<List<Picture>, int?>(
  (ref, albumId) async {
    return await getPictureList(albumId: albumId);
  },
);

// お気に入り写真を管理する Provider
final favoritePicturesProvider =
    ChangeNotifierProvider<FavoritePictureNotifier>(
  (ref) => FavoritePictureNotifier(),
);

class FavoritePictureNotifier extends ChangeNotifier {
  List<Picture> favoriteList = [];

  Future getFavoritePictureList() async {
    final allPictures = await getPictureList();
    favoriteList = []; // 初期化して重複を防ぐ
    await Future.forEach(allPictures, (Picture item) async {
      final isFavorite = await getFavorite('picture', item.id);
      if (isFavorite) {
        favoriteList.add(item);
      }
    });
    notifyListeners();
  }

  // マイページでお気に入りから削除されたら実行
  void removeMyPageFavorite(int id) {
    final removedItem = favoriteList.firstWhere((element) => element.id == id);
    favoriteList.remove(removedItem);
    notifyListeners();
  }
}
