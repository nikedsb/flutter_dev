import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/models/post.dart';
import 'package:sns_answer/providers/post.dart';
import 'package:sns_answer/providers/user.dart';
import 'package:sns_answer/repositories/post.dart';
import 'package:sns_answer/common_parts.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListProvider); //監視
    return Scaffold(
      appBar: AppBar(
        title: const Text("投稿"),
        automaticallyImplyLeading: false,
      ), //戻るボタンを非表示にする
      body: postList.when(
        data: (data) => PostsWidget(
          postList: data,
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}

class PostsWidget extends StatelessWidget {
  final List<Post> postList;
  final bool isMyPage;
  const PostsWidget({super.key, required this.postList, this.isMyPage = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // ListViewは必要なすぺーすのみ使う→何もしないと埋め尽くす。
      itemCount: postList.length,
      itemBuilder: ((context, index) {
        final post = postList[index];
        return PostWidget(id: post.id, post: post);
      }),
    );
  }
}

//いいね状態を管理する必要があるのでConsumerWidget
class PostWidget extends ConsumerWidget {
  final int id;
  final Post post;
  final bool isMyPage;
  const PostWidget(
      {super.key, required this.id, required this.post, this.isMyPage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Card(
      child: Column(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: userList.when(
              data: (data) => [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 8),
                  child: Text(data[post.userId].name),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text("@${data[post.userId].username}"),
                )
              ],
              error: ((error, stackTrace) => [const Text("erro")]),
              loading: (() => [const Text("loading userInfo")]),
            )),
        // タイトル
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            post.title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            post.body,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        // いいねボタン
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(right: 20),
          child: FavoriteWidget(
            id: id,
            type: "post",
            isMyPage: isMyPage,
          ),
        )
      ]),
    );
  }
}
