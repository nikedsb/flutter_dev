import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/providers/common.dart';
import 'package:sns_answer/repositories/common.dart';
import 'package:tuple/tuple.dart';
import 'package:sns_answer/repositories/picture.dart';
import 'package:sns_answer/providers/post.dart';
import 'package:sns_answer/providers/album.dart';
import 'package:sns_answer/providers/picture.dart';

//providerに流す引数用のメンバーを定義しておく必要がある。
class FavoriteWidget extends ConsumerWidget {
  final int id;
  final String type; // post or album or picture
  final bool isMyPage;
  const FavoriteWidget(
      {super.key,
      required this.id,
      required this.type,
      required this.isMyPage});

  void _toggleFavorite(WidgetRef ref, Tuple2<String, int> itemInfo) async {
    ref.read(favoriteProvider(itemInfo)).setItemFavorite();

    if (type == 'album') {
      final newFavorites = await getPictureList(albumId: id);
      for (final item in newFavorites) {
        setFavorite(
          'picture',
          item.id,
          isFavorite: ref
              .read(
                favoriteProvider(itemInfo),
              )
              .isFavorite,
        );
      }
    }
    if (isMyPage) {
      // マイページかどうか判定
      switch (type) {
        // 投稿かアルバムか写真かで場合分け
        case 'post':
          ref.read(favoritePostsProvider).removeMyPageFavorite(id);
          break;
        case 'album':
          ref.read(favoriteAlbumsProvider).removeMyPageFavorite(id);
          break;
        case 'picture':
          ref.read(favoritePicturesProvider).removeMyPageFavorite(id);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemInfo = Tuple2(type, id);
    final initialized = ref
        .watch(favoriteProvider(itemInfo).select((value) => value.initialized));
    final isFavorite = ref.watch(favoriteProvider(itemInfo)).isFavorite;

    if (!initialized) {
      ref.read(favoriteProvider(itemInfo)).getItemFavorite();
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return IconButton(
        onPressed: () => _toggleFavorite(ref, itemInfo),
        icon: isFavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
        color: Colors.pink);
  }
}

// 追加
class MyBottomNavigationBar extends ConsumerWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  // ボトムバーのタブがタップされたら実行される
  void toOtherPages(int index, BuildContext context, WidgetRef ref) {
    ref
        .read(currentTabProvider.notifier)
        .update((state) => index); // currentTabProvider の値を変更
    // index に応じてページ遷移
    switch (index) {
      case 0: // 投稿一覧ページに遷移
        Navigator.of(context).pushNamed('/');
        break;
      case 1: // アルバム一覧ページに遷移
        Navigator.of(context).pushNamed('/albums');
        break;
      case 2: // 写真一覧ページに遷移
        Navigator.of(context).pushNamed('/pictures');
        break;
      case 3: // マイページに遷移
        Navigator.of(context).pushNamed('/mypage');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          label: '投稿',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections),
          label: 'アルバム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: '写真',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
      ],
      // タップされたら toOtherPages() を実行
      onTap: (index) => toOtherPages(index, context, ref),
      // currentIndex は currentTabProvider を参照
      currentIndex: ref.watch(currentTabProvider),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black38,
    );
  }
}
