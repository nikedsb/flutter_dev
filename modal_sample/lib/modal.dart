import 'package:flutter/material.dart';

@immutable
class ModalWidget extends StatefulWidget {
  const ModalWidget({Key? key}) : super(key: key);

  @override
  State<ModalWidget> createState() => _ModalState();
}

class _ModalState extends State<ModalWidget> {
  // モーダルを表示するかどうかを管理するための変数
  bool modalFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modal'),
      ),
      body: Container(
        color: modalFlag ? Colors.grey : Colors.white,
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text('Modal Open Button'),
                  // ボタンを押されたときはモーダルを開く
                  onPressed: () => setState(
                    () {
                      modalFlag = !modalFlag;
                    },
                  ),
                ),
              ),
              if (modalFlag) // modalFlag が true の時だけモーダルを表示
                Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.all(32),
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Modal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        // バツボタンを押されたときはモーダルを閉じる
                        onPressed: () => setState(
                          () {
                            modalFlag = !modalFlag;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
