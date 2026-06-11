import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mlb_roster/models/roster_model.dart';

class RosterService {
  Future<List<TeamModel>> fetchTeams() async {
    final url = Uri.parse('https://statsapi.mlb.com/api/v1/teams/?sportId=1');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final teamResponse = TeamResponse.fromJson(jsonData);

      return teamResponse.data;
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<RosterModel> fetchRoster(String teamId) async {
    final url = Uri.parse('https://statsapi.mlb.com/api/v1/teams/$teamId/roster');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final rosterResponse = RosterModel.fromJson(jsonData);

      return rosterResponse;
    } else {
      throw Exception('Failed to load roster');
    }
  }

  Future<List<PlayerModel>> fetchPlayers(String teamId, List<String> playerIds) async {
    List<PlayerModel> players = [];

    for(String playerId in playerIds) {
      final url = Uri.parse('https://statsapi.mlb.com/api/v1/people/$playerId');
      final response = await http.get(url);

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final playerModel = PlayerModel.fromJson(jsonData);

        players.add(playerModel);
      } else {
        throw Exception('Failed to load player');
      } 
    }

    if(players.isNotEmpty) {
      return players;
    } else {
      throw Exception('Failed to load roster');
    }
  }
}