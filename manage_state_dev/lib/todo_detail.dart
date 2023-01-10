import 'package:flutter/material.dart';
import 'package:manage_state_dev/todo_item.dart';
import 'package:manage_state_dev/todo_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoDetailPage extends ConsumerWidget {
  final int index;
  final TodoItem todoItem;

  const TodoDetailPage({
    Key? key,
    required this.index,
    required this.todoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncompletedList =
        ref.watch<UncompletedNotifier>(UncompletedListProvider);
    final completedList = ref.watch<CompletedNotifier>(CompletedListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 詳細'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 4.0),
                child: const Text('タイトル'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  width: 300,
                  child: Text(todoItem.title),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: const Text('内容'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 300,
                  height: 200,
                  child: Text(todoItem.content),
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    updateTodo(todoItem, index, uncompletedList, completedList);
                    Navigator.of(context).pop();
                  }, // 後で追加
                  child: todoItem.isCompleted
                      ? const Text('未完了にする')
                      : const Text('完了にする'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateTodo(TodoItem todoItem, int index, UncompletedNotifier uncompleted,
      CompletedNotifier completed) {
    if (todoItem.isCompleted) {
      uncompleted.addToList(todoItem);
      completed.removeFromList(index);
    } else {
      completed.addToList(todoItem);
      uncompleted.removeFromList(index);
    }
  }
}
