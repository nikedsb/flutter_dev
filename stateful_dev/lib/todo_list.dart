import 'package:flutter/material.dart';
import 'package:stateful_dev/todo_item.dart';

class TodoListWidget extends StatefulWidget {
  TodoListWidget({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoListWidget> {
  int bottomIndex = 0;
  List<TodoItem> allItem = [TodoItem(), TodoItem(), TodoItem()];
  List<TodoItem> completedItem = [];
  List<TodoItem> displayItem = [];
  int allTodoCount = 0;
  int completedTodoCount = 0;

  @override
  Widget build(BuildContext context) {
    allTodoCount = allItem.length;
    completedItem = allItem.where((TodoItem elem) => elem.isCompleted).toList();
    completedTodoCount = completedItem.length;
    displayItem = completedItem;
    if (bottomIndex == 0) {
      displayItem =
          allItem.where((TodoItem elem) => !elem.isCompleted).toList();
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(children: [
          Text("Todo一覧"),
          Text("完了済み$completedTodoCount/$allTodoCount")
        ]),
      ),
      body: ListView(
        children: displayItem,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.not_interested), label: "未完了"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "完了")
        ],
        onTap: (final index) {
          setState(() {
            bottomIndex = index;
          });
        },
        currentIndex: bottomIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
