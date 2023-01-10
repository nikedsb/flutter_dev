void main() async {
  await delayFiveSeconds();
  print(delayFiveSeconds());
  syncFunc();
  print("main func finished");
}

Future<void> delayFiveSeconds() async {
  await Future.delayed(Duration(seconds: 5));
}

void syncFunc() {
  print("すぐに実行しました。");
}
