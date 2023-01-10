import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_state_dev/todo_item.dart';
import 'package:manage_state_dev/todo_list.dart';

final formKeyProvider = ChangeNotifierProvider<FormKeyChangeNotifier>(
    (ref) => FormKeyChangeNotifier());

class FormKeyChangeNotifier extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}

final formValueProvider = ChangeNotifierProvider<FormValueChangeNotifier>(
    ((ref) => FormValueChangeNotifier()));

class FormValueChangeNotifier extends ChangeNotifier {
  Map<String, String> formValue = {};
}

class TodoAddPage extends ConsumerWidget {
  TodoAddPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<FormState> formKey =
        ref.watch<FormKeyChangeNotifier>(formKeyProvider).formKey;
    Map<String, String> formValue =
        ref.watch<FormValueChangeNotifier>(formValueProvider).formValue;
    UncompletedNotifier uncompletedList =
        ref.watch<UncompletedNotifier>(UncompletedListProvider);
    CompletedNotifier completeList =
        ref.watch<CompletedNotifier>(CompletedListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 追加'),
      ),
      // ...
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 32.0),
                padding: const EdgeInsets.all(4.0),
                width: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                  ),
                  onSaved: (value) {
                    // FormState の save() メソッドが呼ばれたら実行
                    formValue['title'] = value.toString(); // 入力値を formValue に格納
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'タイトルを入力してください。';
                    } else if (value.length > 30) {
                      return 'タイトルは30文字以内で入力してください。';
                    }
                    return null; // null が返されたらバリデーションクリア
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 32.0),
                padding: const EdgeInsets.all(4.0),
                width: 300,
                height: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '内容',
                    // labelTextを上寄せにする
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 8,
                  onSaved: (value) {
                    // FormState の save() メソッドが呼ばれたら実行
                    formValue['content'] =
                        value.toString(); // 入力値を formValue に格納
                  },
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? '内容を入力してください。'
                        : null;
                  },
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      uncompletedList.addToList(TodoItem(
                          id: uncompletedList.uncompletedList.length +
                              completeList.completedList.length +
                              1,
                          title: formValue["title"]!,
                          content: formValue["content"]!,
                          isCompleted: true));
                      Navigator.of(context).pop(); // 前のページ（一覧ページ）に戻る
                    }
                  }, // 後で追加
                  child: const Text('Todo を追加'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
