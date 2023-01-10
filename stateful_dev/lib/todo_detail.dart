import 'package:flutter/material.dart';
import 'package:stateful_dev/todo_item.dart';

class ItemDetailWidget extends StatelessWidget {
  ItemDetailWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final ItemDetailParameters args =
    //     ModalRoute.of(context)?.settings.arguments as ItemDetailParameters;
    final TodoItem args =
        ModalRoute.of(context)?.settings.arguments as TodoItem;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(children: [const Text("Todo詳細")]),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text("タイトル"),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(args.id.toString()),
                        )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("内容"),
                  Row(
                    children: [
                      Expanded(
                          child: ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 200),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(args.content.toString()),
                        )),
                      ))
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              
                              Navigator.of(context).pop();
                            },
                            child: args.isCompleted
                                ? Text("未完了にする")
                                : Text("完了にする")))
                  ])
                ])
                // This trailing comma makes auto-formatting nicer for build methods.
                )));
  }
}
