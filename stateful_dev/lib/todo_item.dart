import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  int id = 1;
  String title = "sample";
  String content = "サンプル";
  bool isCompleted = false;
  TodoItem({super.key});

  @override
  TodoItemState createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Text(widget.id.toString()),
      title: Text(widget.content),
      trailing: IconButton(
          onPressed: toggleisCompleted,
          icon: Icon(Icons.check_box,
              color: widget.isCompleted ? Colors.blue : Colors.grey)),
      onTap: (() {
        debugPrint("pushed");
        Navigator.of(context).pushNamed("itemDetail", arguments: widget);
        // ItemDetailParameters(
        //     id: widget.id,
        //     content: widget.content,
        //     isCompleted: widget.isCompleted));
      }),
    ));
  }

  void toggleisCompleted() {
    setState(() {
      debugPrint("before:${widget.isCompleted.toString()}");
      widget.isCompleted = !widget.isCompleted;
      debugPrint("after:${widget.isCompleted.toString()}");
    });
  }
}

class ItemDetailParameters {
  int id;
  String content;
  bool isCompleted;

  ItemDetailParameters(
      {required this.id, required this.content, required this.isCompleted});
}
