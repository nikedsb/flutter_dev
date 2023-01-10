void main() {
  // question1();
  // final List<int> numbers = [17,7];
  // numbers.sort();
  // question2(numbers[0], numbers[1]);
  final shoppingListMap = {
    'パン': 3,
    'リンゴ': 1,
    '牛乳': null,
    '卵': 10,
  };
  final itemPriceListMap = {
    'パン': 120,
    'リンゴ': 110,
    '牛乳': 200,
    '卵': 15,
  };
  calcItemPrice(prices: itemPriceListMap, wants: shoppingListMap);
}

void question1() {
  for (int i = 1; i <= 100; i++) {
    int margin = i % 3;
    int margin2 = i % 5;
    if (margin == 0 && margin2 == 0) {
      print("FizzBuzz");
    } else if (margin == 0) {
      print("Fizz");
    } else if (margin2 == 0) {
      print("Buzz");
    } else {
      print(i);
    }
  }
}

void question2(int a, int b) {
  for (var i = 1; i <= 100; i++) {
    int margin = i % a;
    int margin2 = i % b;
    if (margin == 0 && margin2 == 0) {
      print("FizzBuzz");
    } else if (margin == 0) {
      print("Fizz");
    } else if (margin2 == 0) {
      print("Buzz");
    } else {
      print(i);
    }
  }
}

void calcItemPrice({required Map prices, required Map wants}) {
  double sum = 0;
  wants.forEach((key, value) {
    value = value ?? 0;
    switch (key) {
      case "パン":
        double pay = 1.1 * prices["パン"] * value;
        sum += pay;
        break;
      case "リンゴ":
        double pay = 1.1 * prices["リンゴ"] * value;
        sum += pay;
        break;
      case "牛乳":
        double pay = 1.1 * prices["牛乳"] * value;
        sum += pay;
        break;
      case "卵":
        double pay = 1.1 * prices["卵"] * value;
        sum += pay;
        break;
      default:
        break;
    }
  });
  int sumInt = sum.toInt();
  print("合計は$sumInt円です。");
}
