import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchesService extends ChangeNotifier {
  static final MatchesService _instance = MatchesService._internal();
  factory MatchesService() => _instance;
  MatchesService._internal();

  static MatchesService get instance => _instance;

  final List<Match> _matches = [
    // Default matches
    Match(
      id: '1',
      homeTeam: 'Manchester United',
      awayTeam: 'Liverpool',
      date: 'Sat, 15 Feb 2025',
      opponentLogo: 'assets/images/liverpool-logo.png',
      basePrice: 75.0,
    ),
    Match(
      id: '2',
      homeTeam: 'Manchester United',
      awayTeam: 'Chelsea',
      date: 'Sat, 22 Feb 2025',
      opponentLogo: 'assets/images/chelsea-logo.png',
      basePrice: 70.0,
    ),
  ];

  List<Match> get matches => List.unmodifiable(_matches);

  void addMatch(Match match) {
    _matches.add(match);
    notifyListeners();
  }

  void updateMatch(String id, Match updatedMatch) {
    final index = _matches.indexWhere((m) => m.id == id);
    if (index >= 0) {
      _matches[index] = updatedMatch;
      notifyListeners();
    }
  }

  void deleteMatch(String id) {
    _matches.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  Match? getMatchById(String id) {
    try {
      return _matches.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }
}
