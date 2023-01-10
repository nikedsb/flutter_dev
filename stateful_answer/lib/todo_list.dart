import 'package:flutter/material.dart';
import 'package:stateful_answer/todo_detail.dart';
import 'package:stateful_answer/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  int bottomBarIndex = 0;
  // このゲッターはなんだ？
  List<TodoItem> get shownList =>
      bottomBarIndex == 0 ? unCompletedList : completedList;
  final List<TodoItem> unCompletedList = [
    TodoItem(
        id: 0, title: "Flutter", content: "Flutterを勉強する", isCompleted: false),
    TodoItem(id: 1, title: "買い物", content: "卵を買う", isCompleted: false),
  ];

  final List<TodoItem> completedList = [
    TodoItem(id: 2, title: "課題", content: "月 3 レポート", isCompleted: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Todo 一覧 (完了済み)${completedList.length} / ${unCompletedList.length}")),
      body: Center(
        child: ListView.builder(
            itemCount: shownList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text("${index + 1}  ${shownList[index].title}"),
                    trailing: Checkbox(
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        onChanged: ((value) {
                          replaceTodoItem(index);
                        }),
                        value: shownList[index].isCompleted),
                    onTap: () => {toDetailPage(index)}),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toAddPage,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.unpublished), label: "未完了"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: "完了"),
        ],
        onTap: changeBottomBarIndex,
        currentIndex: bottomBarIndex,
        selectedItemColor: Colors.blue,
      ),
    );
  }

// 発想として抜けてた部分
  void replaceTodoItem(int index) {
    //　変化前の値
    final preIsCompleted = shownList[index].isCompleted;
    setState(() {
      final tappedItem = shownList[index];
      final removeFrom =
          tappedItem.isCompleted ? completedList : unCompletedList;
      final addTo = tappedItem.isCompleted ? unCompletedList : completedList;

      addTo.add(tappedItem..toggleIsCompleted());
      removeFrom.removeAt(index);
    });
  }

  void addTodoItem(Map<String, String> formValue) {
    setState(
      () {
        unCompletedList.add(
          TodoItem(
            id: unCompletedList.length + completedList.length,
            title: formValue['title']!,
            content: formValue['content']!,
            isCompleted: false,
          ),
        );
      },
    );
  }

  void changeBottomBarIndex(index) {
    setState(() {
      bottomBarIndex = index;
    });
  }

  void toAddPage() {
    // 遷移
    Navigator.of(context).pushNamed(
      "/add",
      arguments: addTodoItem,
    );
  }

  void toDetailPage(int index) {
    Navigator.of(context).pushNamed("/detail",
        arguments:
            TodoDetailArguments(index, shownList[index], replaceTodoItem));
  }
}




