import 'package:flutter/material.dart';
import 'package:mlb_roster/providers/roster_provider.dart';
import 'package:mlb_roster/screens/team_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RosterProvider(),
      child: MLBRosterApp()
    )
  );
}

class MLBRosterApp extends StatelessWidget {
  const MLBRosterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MLB Rosters',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.blue.shade800
        ),
      ),
      home: TeamScreen()
    );
  }
}

