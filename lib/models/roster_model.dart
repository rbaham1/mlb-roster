import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamResponse {
  final List<TeamModel> data;

  TeamResponse({required this.data});

  factory TeamResponse.fromJson(Map<String, dynamic> json) {
    return TeamResponse(
      data: (json['teams'] as List).map((teamJson) => TeamModel.fromJson(teamJson)).toList()
    );
  }
}

class TeamModel {
  final String teamName;
  final String teamId;
  final SvgPicture teamLogo;

  TeamModel({required this.teamName, required this.teamId, required this.teamLogo});

  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(
      teamName: json['name'],
      teamId: json['id'].toString(),
      teamLogo: SvgPicture.network("https://www.mlbstatic.com/team-logos/team-cap-on-light/${json['id']}.svg")
    );
  }
}

class RosterModel {
  final List<String> playerIds;

  RosterModel({required this.playerIds});

  factory RosterModel.fromJson(Map<String, dynamic> json){
    return RosterModel(
      playerIds: (json['roster'] as List).map((player) => player['person']['id'].toString()).toList()
    );
  }
}

class PlayerModel {
  final String fullName;
  final String fullFMLName;
  final String height;
  final String weight;
  final String number;
  final String position;
  final String positionAbbrev;
  final String birthCity;
  final String? birthStateProvince;
  final String birthCountry;
  final DateTime birthDate;
  final Image playerHeadshot;

  PlayerModel({required this.fullName, required this.number, required this.position, required this.playerHeadshot, required this.fullFMLName, required this.height, required this.weight, required this.positionAbbrev, required this.birthCity, this.birthStateProvince, required this.birthCountry, required this.birthDate});

  factory PlayerModel.fromJson(Map<String, dynamic> json){
    final playerId = (json['people'] as List).map((playerId) => playerId['id']).first;
    return PlayerModel(
      fullName: (json['people'] as List).map((fullName) => fullName['fullName']).first, 
      fullFMLName: (json['people'] as List).map((fullFMLName) => fullFMLName['fullFMLName']).first, 
      height: (json['people'] as List).map((height) => height['height']).first,
      weight: (json['people'] as List).map((weight) => weight['weight']).first.toString(),
      number: (json['people'] as List).map((number) => number['primaryNumber']).first, 
      position: (json['people'] as List).map((position) => position['primaryPosition']['name']).first,
      positionAbbrev: (json['people'] as List).map((position) => position['primaryPosition']['abbreviation']).first,
      birthCity: (json['people'] as List).map((birthCity) => birthCity['birthCity']).first,
      birthStateProvince: (json['people'] as List).map((birthStateProvince) => birthStateProvince['birthStateProvince']).first,
      birthCountry: (json['people'] as List).map((birthCountry) => birthCountry['birthCountry']).first,
      birthDate: DateTime.parse((json['people'] as List).map((birthDate) => birthDate['birthDate']).first),
      playerHeadshot: Image.network(
        'https://img.mlbstatic.com/mlb-photos/image/upload/w_213,d_people:generic:headshot:silo:current.png,q_auto:best,f_auto/v1/people/$playerId/headshot/67/current',
        fit: BoxFit.fill,)
    );
  }
}