import 'package:flutter/material.dart';

// データクラスみたいな感じ？
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


