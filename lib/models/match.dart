class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String date;
  final String? opponentLogo;
  final double basePrice;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    this.opponentLogo,
    required this.basePrice,
  });
}

// Stand pricing configuration with percentage modifiers
class StandPricing {
  final String name;
  final double priceModifier; // Percentage modifier from base price (e.g., 1.15 = +15%)
  final double upperTierModifier; // Percentage modifier for upper tier
  final double lowerTierModifier; // Percentage modifier for lower tier

  const StandPricing({
    required this.name,
    required this.priceModifier,
    required this.upperTierModifier,
    required this.lowerTierModifier,
  });

  double getMinPrice(double basePrice) {
    return basePrice * priceModifier * lowerTierModifier;
  }

  double getUpperTierPrice(double basePrice) {
    return basePrice * priceModifier * upperTierModifier;
  }

  double getLowerTierPrice(double basePrice) {
    return basePrice * priceModifier * lowerTierModifier;
  }
}

// Predefined stand configurations
class StandConfigurations {
  static const List<StandPricing> stands = [
    StandPricing(
      name: 'Sir Alex Ferguson Stand',
      priceModifier: 1.20, // +20% from base
      upperTierModifier: 1.12, // +12% from stand price
      lowerTierModifier: 1.0, // base stand price
    ),
    StandPricing(
      name: 'East Stand',
      priceModifier: 1.05, // +5% from base
      upperTierModifier: 1.13, // +13% from stand price
      lowerTierModifier: 1.0,
    ),
    StandPricing(
      name: 'Stretford End',
      priceModifier: 1.25, // +25% from base (premium)
      upperTierModifier: 1.11, // +11% from stand price
      lowerTierModifier: 1.0,
    ),
    StandPricing(
      name: 'South Stand',
      priceModifier: 0.95, // -5% from base (cheaper)
      upperTierModifier: 1.14, // +14% from stand price
      lowerTierModifier: 1.0,
    ),
  ];

  static StandPricing getStand(String name) {
    return stands.firstWhere(
      (s) => s.name == name,
      orElse: () => stands.first,
    );
  }

  // Calculate all stand prices for a match
  static List<Map<String, dynamic>> getStandsForMatch(double basePrice) {
    return stands.map((stand) {
      final lowerPrice = stand.getLowerTierPrice(basePrice);
      final upperPrice = stand.getUpperTierPrice(basePrice);
      return {
        'name': stand.name,
        'minPrice': lowerPrice,
        'tiers': [
          {'name': 'Upper Tier', 'price': upperPrice},
          {'name': 'Lower Tier', 'price': lowerPrice},
        ],
      };
    }).toList();
  }
}
