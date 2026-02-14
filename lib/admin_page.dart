import 'package:flutter/material.dart';
import 'dart:ui';

import 'auth_styles.dart';
import '../services/matches_service.dart';
import '../models/match.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: AuthStyles.panelBlurSigma,
                        sigmaY: AuthStyles.panelBlurSigma,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: AuthStyles.panelDecoration,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.admin_panel_settings,
                              color: Color(0xFFDA020E),
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Admin Panel',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Manage matches',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add Match Button
                            ElevatedButton.icon(
                              onPressed: null, // TODO: Navigate to Add Match page
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDA020E),
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('Add Match'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Matches List
                Expanded(
                  child: matches.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: matches.length,
                          itemBuilder: (context, index) {
                            final match = matches[index];
                            return _buildMatchCard(match);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AuthStyles.panelBlurSigma,
            sigmaY: AuthStyles.panelBlurSigma,
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.all(16),
            decoration: AuthStyles.panelDecoration,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sports_soccer_outlined,
                  size: 64,
                  color: Colors.black54,
                ),
                SizedBox(height: 16),
                Text(
                  'No matches found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Add a new match to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(Match match) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AuthStyles.panelBlurSigma,
            sigmaY: AuthStyles.panelBlurSigma,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: AuthStyles.panelDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Team logos
                    if (match.opponentLogo != null)
                      Image.asset(
                        match.opponentLogo!,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey,
                            child: const Icon(Icons.sports_soccer),
                          );
                        },
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${match.homeTeam} vs ${match.awayTeam}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            match.date,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    Row(
                      children: [
                        IconButton(
                          onPressed: null, // TODO: Edit match
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            // Confirm delete
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Match?'),
                                content: Text(
                                  'Are you sure you want to delete ${match.homeTeam} vs ${match.awayTeam}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      matchesService.deleteMatch(match.id);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Match deleted'),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Base price info
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDA020E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Base Price: \$${match.basePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFDA020E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
