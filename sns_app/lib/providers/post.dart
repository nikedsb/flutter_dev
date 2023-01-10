import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/models/post.dart';
import 'package:sns_app/repositories/post.dart';

final postFutureProvider =
    FutureProvider<List<Post>>((_) async => await fetchPosts());
