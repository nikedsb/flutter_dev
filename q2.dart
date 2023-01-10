import 'q1.dart';

void main() {
  BookStock bookStock = BookStock("プログラミングを学ぼう", "山田デミオ", 1500, 1, false);
  bookStock.describe();
  print(bookStock.msgGet);
  bookStock.bookPurchased();
  bookStock.describe();
}
