void main() {
  printTime();
  counter();
}

Future<DateTime> getTime() async {
  var a = await Future.delayed(Duration(seconds: 3), () => DateTime.now());
  return a;
}

void printTime() async {
  print(DateTime.now());
  print(await getTime());
}

void counter() async {
  print(0);
  for (int i = 1; i < 6; i++) {
    await Future.delayed(Duration(seconds: 1), () {
      print(i);
    });
  }
}
