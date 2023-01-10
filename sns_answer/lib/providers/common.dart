// 一つのプロバイダーで複数のいいね状況を管理したい時→familyを使う
//ref.read()などの時に引数を渡すことができる。
// 複数の値を入れたい時は、tupleパッケージを使うか、freezedで生成したモデルのオブジェクトを使う。

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/repositories/common.dart';
import 'package:tuple/tuple.dart';

final favoriteProvider =
    ChangeNotifierProvider.family<FavoriteNotifier, Tuple2<String, int>>(
        (ref, itemInfo) {
  return FavoriteNotifier(type: itemInfo.item1, id: itemInfo.item2);
});

class FavoriteNotifier extends ChangeNotifier {
  final String type;
  final int id;
  bool isFavorite = false;
  bool initialized = false; //果たして本当に必要なのか

  FavoriteNotifier({required this.type, required this.id});

  Future getItemFavorite() async {
    isFavorite = await getFavorite(type, id);
    initialized =
        true; //初期化と言うより、awaitがちゃんと完了して値が最新に更新されているかどうかというフラグ。futuerプロヴァイダーではないので検知ができないってことかな。
    notifyListeners();
  }

  void setItemFavorite() async {
    setFavorite(type, id, isFavorite: isFavorite);
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

final currentTabProvider = StateProvider<int>((ref) => 0);
