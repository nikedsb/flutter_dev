void main() {
  BookStock bookStock = BookStock(1000, 5, "実践Django", "池田七生");
  bookStock.describe();
  print(bookStock.getMsg);
}

class Book {
  String title;
  String author;

  Book(this.title, this.author);

  void describe() {
    print('title: ${title}、著者: ${author}');
  }
}

class BookStock extends Book {
  static String msg = '在庫数を表示';
  bool ordering;
  int price;
  int stock;

  // bool は名前付き引数でないと avoid_positional_boolean_parameters に引っかかる
  BookStock(this.price, this.stock, String title, String author,
      {this.ordering = false})
      : super(title, author);

  @override
  void describe() {
    print('${this.title}（${author}）: 在庫数 ${stock}、発注済み ${ordering}');
  }

  void bookPurchased() {
    print('${title}: ${price}円 が 1 冊売れました');
    stock -= 1;
    if (stock == 0) {
      ordering = true;
    }
  }

  String get getMsg => msg;
}
