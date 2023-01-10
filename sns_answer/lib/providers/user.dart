import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_answer/models/user.dart';
import 'package:sns_answer/repositories/user.dart';

final usernameProvider = StateProvider((ref) => 'ゲスト');

// 投稿・アルバムの投稿者情報表示に使用
final userListProvider = FutureProvider<List<User>>(
  (ref) async {
    return await getUsers();
  },
);
