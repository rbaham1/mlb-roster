import 'package:flutter/material.dart';
import 'package:mlb_roster/models/roster_model.dart';
import 'package:mlb_roster/services/roster_service.dart';

class RosterProvider extends ChangeNotifier {
  final rosterService = RosterService();
  List<TeamModel> teams = [];
  RosterModel roster = RosterModel(playerIds: []);
  List<PlayerModel> players = [];
  String? errorMessage = "";
  bool isLoading = false;

  Future<void> fetchTeams() async {
    errorMessage = "";
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      teams = await rosterService.fetchTeams();
    } catch (error) {
      errorMessage = "Failed to load teams";
    }
    // notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRoster(String teamId) async {
    errorMessage = "";
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();
      roster = await rosterService.fetchRoster(teamId);
      // After fetching the roster, fetch all players for that roster
      players = await rosterService.fetchPlayers(teamId, roster.playerIds);
    } catch (error) {
      errorMessage = "Failed to load roster";
    }
    // notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchPlayers(String teamId, List<String> playerIds) async {
  //   errorMessage = "";
  //   try {
  //     players = await rosterService.fetchPlayers(teamId, playerIds);
  //   } catch (error) {
  //     errorMessage = "Failed to load player";
  //   }
  //   notifyListeners();
  // }
}