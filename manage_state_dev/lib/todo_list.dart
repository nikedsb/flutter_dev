import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_state_dev/todo_item.dart';

// 表示内容の切り替え用
final bottomIndexProvider = StateProvider<int>(((ref) => 0));

final UncompletedListProvider = ChangeNotifierProvider<UncompletedNotifier>(
    ((ref) => UncompletedNotifier()));

class UncompletedNotifier extends ChangeNotifier {
  List<TodoItem> uncompletedList = [
    TodoItem(
        id: 0, title: "Flutter", content: "Flutterを勉強する", isCompleted: false),
    TodoItem(id: 1, title: "買い物", content: "卵を買う", isCompleted: false),
  ];

  void addToList(TodoItem elem) {
    // 追加するtodoのboolを反転
    elem.toggleIsCompleted();
    // 要素を追加
    uncompletedList.add(elem);
    // 変更を通知
    notifyListeners();
  }

  void removeFromList(int index) {
    uncompletedList.removeAt(index);
    notifyListeners();
  }
}

final CompletedListProvider =
    ChangeNotifierProvider<CompletedNotifier>(((ref) => CompletedNotifier()));

class CompletedNotifier extends ChangeNotifier {
  final List<TodoItem> completedList = [
    TodoItem(id: 2, title: "課題", content: "月 3 レポート", isCompleted: true)
  ];

  void addToList(TodoItem elem) {
    // 追加するtodoのboolを反転
    elem.toggleIsCompleted();
    // 要素を追加
    completedList.add(elem);
    // 変更を通知
    notifyListeners();
  }

  void removeFromList(int index) {
    completedList.removeAt(index);
    notifyListeners();
  }
}

// 描画内容
class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBarIndex = ref.watch<int>(bottomIndexProvider);
    final uncompletedList =
        ref.watch<UncompletedNotifier>(UncompletedListProvider);
    final completedList = ref.watch<CompletedNotifier>(CompletedListProvider);
    int completedCount = completedList.completedList.length;
    int uncompletedCount = uncompletedList.uncompletedList.length;

    List<TodoItem> shownList = bottomBarIndex == 0
        ? uncompletedList.uncompletedList
        : completedList.completedList;

    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Todo 一覧 (完了済み)${completedCount.toString()} / ${(completedCount + uncompletedCount).toString()}")),
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
                            // 前の値確認
                            if (value!) {
                              // true→false
                              completedList.addToList(shownList[index]);
                              uncompletedList.removeFromList(index);
                            } else {
                              //false→true
                              uncompletedList.addToList(shownList[index]);
                              completedList.removeFromList(index);
                            }
                          }),
                          value: shownList[index].isCompleted),
                      onTap: () => {
                            toDetailPage(
                                DetailPageParams(
                                    index: index, item: shownList[index]),
                                context)
                          }));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add");
        }, //toAddPage,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.unpublished), label: "未完了"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: "完了"),
        ],
        onTap: ((value) {
          ref.read(bottomIndexProvider.notifier).update((state) => value);
        }),
        currentIndex: bottomBarIndex,
        selectedItemColor: Colors.blue,
      ),
    );
  }

  void toDetailPage(DetailPageParams detailParams, BuildContext context) {
    Navigator.of(context).pushNamed("/detail", arguments: detailParams);
  }
}

class DetailPageParams {
  int index;
  TodoItem item;
  DetailPageParams({required this.index, required this.item});
}
