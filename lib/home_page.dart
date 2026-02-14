import 'package:flutter/material.dart';
import 'dart:ui';

import 'auth_styles.dart';
import 'match_detail_page.dart';
import 'services/matches_service.dart';
import 'models/match.dart' as match_model;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final matchesService = MatchesService.instance;

  @override
  void initState() {
    super.initState();
    matchesService.addListener(_onMatchesChanged);
  }

  @override
  void dispose() {
    matchesService.removeListener(_onMatchesChanged);
    super.dispose();
  }

  void _onMatchesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final matches = matchesService.matches;
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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Hero CTA Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/Manchester-United-Logo-1-1155x770-removebg-preview.png',
                                  width: 80,
                                  height: 53,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Watch Manchester United",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "from the stands",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Experience the magic of Old Trafford live!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Navigate to fixtures or tickets
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDA020E),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(Icons.confirmation_num),
                                  label: const Text(
                                    "Buy your ticket!",
                                    style: TextStyle(
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
                    const SizedBox(height: 32),
                    // Upcoming matches preview
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Upcoming Matches",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (matches.isEmpty)
                                const Text(
                                  'No upcoming matches',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                )
                              else
                                ...matches.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final match = entry.value;
                                  return Column(
                                    children: [
                                      _buildMatchPreview(
                                        context,
                                        match.homeTeam,
                                        match.awayTeam,
                                        match.date,
                                        match.opponentLogo ?? '',
                                        match.basePrice,
                                      ),
                                      if (index < matches.length - 1)
                                        const Divider(height: 24),
                                    ],
                                  );
                                }),
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

  Widget _buildMatchPreview(BuildContext context, String home, String away, String date, String opponentLogo, double basePrice) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchDetailPage(
              homeTeam: home,
              awayTeam: away,
              date: date,
              opponentLogo: opponentLogo,
              basePrice: basePrice,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  home,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDA020E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "vs",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDA020E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              away,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
