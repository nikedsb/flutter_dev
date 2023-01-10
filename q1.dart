class Book {
  String title;
  String author;
  Book(this.title, this.author);
  void describe() {
    print("タイトル：${this.title}\n著者：${this.author}");
  }
}

class BookStock extends Book {
  int price;
  int stock;
  bool ordering = false;
  static String msg = "在庫数を確認";
  String get msgGet => msg;

  BookStock(String title, String author, this.price, this.stock, this.ordering)
      : super(title, author);
  @override
  void describe() {
    print(
        "${this.title}(${this.author})：在庫数${this.stock}、発注済み ${this.ordering}");
  }

  void bookPurchased() {
    print("${this.title}:${this.price}円が一冊売れました。");
    if (this.stock == 0) {
      this.ordering = true;
    } else if (this.stock >= 1) {
      this.stock -= 1;
    }

    if (this.stock == 0) {
      this.ordering = true;
    }
  }
}
