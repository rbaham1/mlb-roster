import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mlb_roster/models/roster_model.dart';

class PlayerInfo extends StatelessWidget {
  final PlayerModel player;
  const PlayerInfo({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final TextStyle textHeaderStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600
    );
    final TextStyle textDetailStyle = TextStyle(
      fontSize: 15
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Full Name: ",
                style: textHeaderStyle,
              ),
              Text(
                player.fullFMLName,
                style: textDetailStyle,
              )
            ],
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              Text(
                "Position: ",
                style: textHeaderStyle,
              ),
              Text(
                player.position,
                style: textDetailStyle,
              )
            ],
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              Text(
                "Number: ",
                style: textHeaderStyle,
              ),
              Text(
                player.number,
                style: textDetailStyle,
              )
            ],
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              Text(
                "Height: ",
                style: textHeaderStyle,
              ),
              Text(
                player.height,
                style: textDetailStyle,
              )
            ],
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              Text(
                "Weight: ",
                style: textHeaderStyle,
              ),
              Text(
                player.weight,
                style: textDetailStyle,
              )
            ],
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              Text(
                "Born: ",
                style: textHeaderStyle,
              ),
              Text(
                "${DateFormat("M/d/yyyy").format(player.birthDate)} in ${player.birthCity}, ${(player.birthStateProvince != null) ? "${player.birthStateProvince}, ${player.birthCountry}" : player.birthCountry}",
                style: textDetailStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}