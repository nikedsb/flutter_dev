import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// todoのデータクラス。
class TodoItem {
  final int id;
  final String title;
  final String content;
  bool isCompleted;
  TodoItem(
      {required this.id,
      required this.title,
      required this.content,
      required this.isCompleted});

  void toggleIsCompleted() => isCompleted = !isCompleted;
}



