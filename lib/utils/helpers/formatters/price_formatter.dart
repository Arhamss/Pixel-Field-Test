class PriceFormatter {
  static String formatThreeDP(double price) {
    return price.toStringAsFixed(3);
  }

  static String formatTen(int price) {
    return price.toString().padLeft(2, '0');
  }
}
