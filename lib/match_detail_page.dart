import 'package:flutter/material.dart';
import 'dart:ui';

import 'auth_styles.dart';
import 'models/cart_item.dart';
import 'models/match.dart';
import 'services/cart_service.dart';

class MatchDetailPage extends StatefulWidget {
  final String homeTeam;
  final String awayTeam;
  final String date;
  final String? opponentLogo;
  final double basePrice;

  const MatchDetailPage({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    this.opponentLogo,
    this.basePrice = 70.0, // Default base price
  });

  @override
  State<MatchDetailPage> createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  String? selectedStand;
  String? selectedTier;
  double? selectedPrice;

  late final List<Map<String, dynamic>> stands;

  @override
  void initState() {
    super.initState();
    // Generate dynamic prices based on base price
    stands = StandConfigurations.getStandsForMatch(widget.basePrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/oldtraffordpic.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AuthStyles.backgroundBlurSigma,
          sigmaY: AuthStyles.backgroundBlurSigma,
        ),
        child: Container(
          color: Colors.black.withOpacity(AuthStyles.backgroundOverlayOpacity),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Match Details'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Match Info Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            children: [
                              // Teams
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Manchester-United-Logo-1-1155x770-removebg-preview.png',
                                    width: 60,
                                    height: 40,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'vs',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  widget.opponentLogo != null
                                      ? Image.asset(
                                          widget.opponentLogo!,
                                          width: 60,
                                          height: 40,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 60,
                                              height: 40,
                                              color: Colors.grey,
                                              child: const Icon(Icons.image_not_supported),
                                            );
                                          },
                                        )
                                      : Container(
                                          width: 60,
                                          height: 40,
                                          color: Colors.grey,
                                          child: const Icon(Icons.sports_soccer),
                                        ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${widget.homeTeam} vs ${widget.awayTeam}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.date,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stand Selection
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1. Select Stand',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...stands.map((stand) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedStand = stand['name'];
                                      selectedTier = null;
                                      selectedPrice = null;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedStand == stand['name']
                                          ? const Color(0xFFDA020E).withOpacity(0.1)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: selectedStand == stand['name']
                                            ? const Color(0xFFDA020E)
                                            : Colors.grey.shade300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stand['name'],
                                          style: TextStyle(
                                            fontWeight: selectedStand == stand['name']
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'from \$${stand['minPrice'].toStringAsFixed(0)}',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Tier Selection
                    if (selectedStand != null) ...[
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: AuthStyles.panelBlurSigma,
                            sigmaY: AuthStyles.panelBlurSigma,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: AuthStyles.panelDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2. Select Tier in $selectedStand',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ...stands
                                    .firstWhere((s) => s['name'] == selectedStand)['tiers']
                                    .map<Widget>((tier) => Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedTier = tier['name'];
                                                selectedPrice = tier['price'];
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: selectedTier == tier['name']
                                                    ? const Color(0xFFDA020E).withOpacity(0.1)
                                                    : Colors.transparent,
                                                border: Border.all(
                                                  color: selectedTier == tier['name']
                                                      ? const Color(0xFFDA020E)
                                                      : Colors.grey.shade300,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Radio<String>(
                                                        value: tier['name'],
                                                        groupValue: selectedTier,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedTier = value;
                                                            selectedPrice = tier['price'];
                                                          });
                                                        },
                                                        activeColor: const Color(0xFFDA020E),
                                                      ),
                                                      Text(
                                                        tier['name'],
                                                        style: TextStyle(
                                                          fontWeight: selectedTier == tier['name']
                                                              ? FontWeight.bold
                                                              : FontWeight.normal,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '\$${tier['price'].toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFFDA020E),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    // Price and Buy Button
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            children: [
                              Text(
                                selectedPrice != null
                                    ? 'Ticket Price: \$${selectedPrice!.toStringAsFixed(2)}'
                                    : 'Tickets from \$${widget.basePrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFDA020E),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: selectedTier != null
                                      ? () {
                                          // Add to cart
                                          final cartItem = CartItem(
                                            matchName: '${widget.homeTeam} vs ${widget.awayTeam}',
                                            homeTeam: widget.homeTeam,
                                            awayTeam: widget.awayTeam,
                                            date: widget.date,
                                            stand: selectedStand!,
                                            tier: selectedTier!,
                                            price: selectedPrice!,
                                          );
                                          CartService.instance.addItem(cartItem);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Added to cart: ${widget.homeTeam} vs ${widget.awayTeam} - $selectedStand $selectedTier',
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDA020E),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    selectedTier != null
                                        ? 'Add Ticket to Cart'
                                        : 'Select Stand and Tier',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
