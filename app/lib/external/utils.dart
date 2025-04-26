class Utils {
  static String formatPrice(dynamic price) {
    return '₹${price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+\b)'),
          (Match match) => '${match[1]},',
        )}';
  }
}
