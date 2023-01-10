import 'package:flutter/material.dart';
import 'package:stateful_answer/todo_item.dart';
import 'package:stateful_answer/todo_list.dart';

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  TodoAddPageState createState() => TodoAddPageState();
}

class TodoAddPageState extends State<TodoAddPage> {
  final formKey = GlobalKey<
      FormState>(); //フォームのフィールドで入力された値を取り出すことができる。具体的にいうと、formKey.currentState?.save()します。
  Map<String, String> formValue = {};

  @override
  Widget build(BuildContext context) {
    final addTodoItem = ModalRoute.of(context)!.settings.arguments! as Function;
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
                      addTodoItem(
                          formValue); // addTodoItem() を呼び出して入力した Todo を保存
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
