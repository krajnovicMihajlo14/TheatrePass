class CartItem {
  final String matchName;
  final String homeTeam;
  final String awayTeam;
  final String date;
  final String stand;
  final String tier;
  final double price;
  int quantity;

  CartItem({
    required this.matchName,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.stand,
    required this.tier,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  String get displayName => '$homeTeam vs $awayTeam';
}
