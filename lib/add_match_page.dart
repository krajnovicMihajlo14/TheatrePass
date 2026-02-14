import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'auth_styles.dart';
import 'models/match.dart';
import 'services/matches_service.dart';

class AddMatchPage extends StatefulWidget {
  const AddMatchPage({super.key});

  @override
  State<AddMatchPage> createState() => _AddMatchPageState();
}

class _AddMatchPageState extends State<AddMatchPage> {
  final _formKey = GlobalKey<FormState>();
  final _opponentController = TextEditingController();
  final _dateController = TextEditingController();
  final _competitionController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFDA020E),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${days[date.weekday % 7]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _saveMatch() {
    if (_formKey.currentState!.validate()) {
      final match = Match(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        homeTeam: 'Manchester United',
        awayTeam: _opponentController.text.trim(),
        date: _dateController.text.trim(),
        competition: _competitionController.text.trim(),
        basePrice: double.parse(_priceController.text.trim()),
        opponentLogo: '',
      );

      MatchesService.instance.addMatch(match);
      Navigator.pop(context);
    }
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
          color: Colors.black.withValues(alpha: AuthStyles.backgroundOverlayOpacity),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Add Match'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Main panel
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
                                // Header
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.sports_soccer,
                                      color: Color(0xFFDA020E),
                                      size: 28,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Match Details',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Opponent field
                                TextFormField(
                                  controller: _opponentController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Opponent Team',
                                    hintText: 'e.g., Liverpool',
                                    labelStyle: const TextStyle(color: Colors.black87),
                                    hintStyle: const TextStyle(color: Colors.black54),
                                    prefixIcon: const Icon(Icons.sports, color: Color(0xFFDA020E)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFDA020E), width: 2),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter opponent team';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Date field
                                TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Match Date',
                                    hintText: 'Select date',
                                    labelStyle: const TextStyle(color: Colors.black87),
                                    hintStyle: const TextStyle(color: Colors.black54),
                                    prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFFDA020E)),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFDA020E)),
                                      onPressed: () => _selectDate(context),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFDA020E), width: 2),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please select match date';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Competition field
                                TextFormField(
                                  controller: _competitionController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Competition',
                                    hintText: 'e.g., Premier League',
                                    labelStyle: const TextStyle(color: Colors.black87),
                                    hintStyle: const TextStyle(color: Colors.black54),
                                    prefixIcon: const Icon(Icons.emoji_events, color: Color(0xFFDA020E)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFDA020E), width: 2),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter competition';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Base price field
                                TextFormField(
                                  controller: _priceController,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Base Ticket Price (£)',
                                    hintText: 'e.g., 75.00',
                                    labelStyle: const TextStyle(color: Colors.black87),
                                    hintStyle: const TextStyle(color: Colors.black54),
                                    prefixIcon: const Icon(Icons.attach_money, color: Color(0xFFDA020E)),
                                    prefixText: '£',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFDA020E), width: 2),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter base price';
                                    }
                                    final price = double.tryParse(value.trim());
                                    if (price == null || price <= 0) {
                                      return 'Please enter a valid price';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _saveMatch,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDA020E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.save),
                          label: const Text(
                            'Add Match',
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _opponentController.dispose();
    _dateController.dispose();
    _competitionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
