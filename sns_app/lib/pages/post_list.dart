import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/models/post.dart';
import 'package:sns_app/models/user.dart';
import 'package:sns_app/providers/post.dart';
import 'package:sns_app/common_parts.dart';
import 'package:sns_app/providers/user.dart';
import 'package:sns_app/repositories/user.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("投稿")),
      body: PostListWidget(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

// 投稿リストの大枠
class PostListWidget extends ConsumerWidget {
  // ListViewの中身を書く。
  PostListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postFutureProvider);
    return posts.when(
        data: ((data) => ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return PostItemWidget(postItem: data[index]);
            }))),
        error: ((error, stackTrace) => Text('Error: $error')),
        loading: (() => const Center(
              child: Text("Loading..."),
            )));
  }
}

// 投稿一つひとつのウィジェット
class PostItemWidget extends ConsumerWidget {
  Post postItem;
  PostItemWidget({Key? key, required this.postItem}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userFutureProvider);

    return users.when(
        data: ((data) {
          User user = data[postItem.userId - 1];
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("${user.name} @${user.username}"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          postItem.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(postItem.body),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )));
        }),
        error: ((error, stackTrace) => Text("Error")),
        loading: (() => Text("loading...")));
  }
}
