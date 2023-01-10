import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

// type ('post' / 'album' / 'picture') の指定された id のいいね状態を取得
Future<bool> getFavorite(String type, int id) async {
  final data = await SharedPreferences.getInstance();
  final isFavorite = data.getBool('$type$id'); // bool 値を保存するので getBool() を使用
  return isFavorite == null ? Future.value(false) : Future.value(isFavorite);
}

// type ('post' / 'album' / 'picture') の指定された id のいいねを設定
void setFavorite(String type, int id, {bool isFavorite = false}) async {
  final data = await SharedPreferences.getInstance();
  data.setBool('$type$id', !isFavorite); // bool 値を設定するので setBool() を使用
}

final bottomIndexProvider = StateProvider<int>((ref) => 0);

void toAnotherPage(int index, BuildContext context, WidgetRef ref) {
  ref.read(bottomIndexProvider.notifier).update((bottomIndex) => index);
  if (index == 0) {
    Navigator.of(context).pushNamed("/");
  } else if (index == 1) {
    Navigator.of(context).pushNamed("/albums");
  } else if (index == 2) {
    Navigator.of(context).pushNamed("/images");
  } else if (index == 3) {
    Navigator.of(context).pushNamed("/myPage");
  }
}

class MyBottomNavigationBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int bottomIndex = ref.watch(bottomIndexProvider);
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.speaker_notes,
            ),
            label: "投稿"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.collections,
            ),
            label: "アルバム"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
            ),
            label: "写真"),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "マイページ",
        ),
      ],
      onTap: (index) {
        toAnotherPage(index, context, ref);
      },
      currentIndex: bottomIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    );
  }
}

final favoriteProvider =
    ChangeNotifierProvider.family<FavoriteNotifier, Tuple2<String, int>>(
  (ref, itemInfo) {
    return FavoriteNotifier(
      type: itemInfo.item1,
      id: itemInfo.item2,
    );
  },
);

class FavoriteNotifier extends ChangeNotifier {
  final String type;
  final int id;
  bool isFavorite = false; // いいね状況
  bool initialized = false; // getFavorite() が実行済みかどうかを表すフラグ

  FavoriteNotifier({
    required this.type,
    required this.id,
  });

  Future getItemFavorite() async {
    isFavorite = await getFavorite(type, id);
    initialized = true; // getFavorite() を実行したので true に変更
    notifyListeners();
  }

  void setItemFavorite() async {
    setFavorite(type, id, isFavorite: isFavorite);
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class FavoriteWidget extends ConsumerWidget {
  final int id;
  final String type; // 'post' or 'album' or 'picture'
  const FavoriteWidget({
    super.key,
    required this.id,
    required this.type,
  });

  void _toggleFavorite(WidgetRef ref, Tuple2<String, int> itemInfo) async {
    ref.read(favoriteProvider(itemInfo)).setItemFavorite();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemInfo = Tuple2<String, int>(type, id);
    final isFavorite = ref.watch(favoriteProvider(itemInfo)).isFavorite;
    // initialized の値を取得
    final initialized = ref
        .watch(favoriteProvider(itemInfo).select((value) => value.initialized));
    if (!initialized) {
      ref.read(favoriteProvider(itemInfo)).getItemFavorite();
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // タップされたときに _toggleFavorite() を実行するため、IconButton を使用
    return IconButton(
      onPressed: () => _toggleFavorite(ref, itemInfo),
      // いいね状況に応じてアイコンを変える
      icon: isFavorite
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border),
      color: Colors.pink,
    );
  }
}
