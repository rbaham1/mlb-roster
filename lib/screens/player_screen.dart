import 'package:flutter/material.dart';
import 'package:mlb_roster/models/roster_model.dart';
import 'package:mlb_roster/widgets/back_arrow.dart';
import 'package:mlb_roster/widgets/player_info.dart';

class PlayerScreen extends StatelessWidget {
  final PlayerModel player;
  const PlayerScreen({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackArrow(displayText: player.fullName,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: player.playerHeadshot,
                  ),
                ),
              ),
              Text(
                "Player Info",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              PlayerInfo(player: player)
            ],
          ),
        )
      )
    );
  }
}