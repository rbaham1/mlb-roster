import 'package:flutter/material.dart';
import 'package:mlb_roster/models/roster_model.dart';
import 'package:mlb_roster/providers/roster_provider.dart';
import 'package:mlb_roster/screens/player_screen.dart';
import 'package:mlb_roster/widgets/back_arrow.dart';
import 'package:provider/provider.dart';

class RosterScreen extends StatefulWidget {
  final TeamModel team;
  const RosterScreen({super.key, required this.team});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RosterProvider>().fetchRoster(widget.team.teamId);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RosterProvider>(context);

    if (provider.errorMessage != null && provider.errorMessage!.isNotEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
              IconButton(
                onPressed: () {
                  provider.errorMessage = "";
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
              ),
              Expanded(
                child: Text(
                  'Roster',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(width: 48,),]),
              Center(child: Text(provider.errorMessage!)),
              
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              BackArrow(displayText: "Roster",),

              SizedBox(height: 20,),

              // Display circular loading indicator while roster is being fetched
              provider.isLoading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: GridView.builder(
                    itemCount: provider.players.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.63
                    ), 
                    itemBuilder: (context, index) {
                      final player = provider.players[index];
                  
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(player: player)
                            )
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)
                                      ),
                                      child: player.playerHeadshot
                                    ),

                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                player.fullName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),

                                              Text(
                                                "${player.positionAbbrev} | #${player.number}",
                                                style: TextStyle(
                                                  color: Colors.grey[600]
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    )
                                  ]
                                ),
                              )
                            ],
                          )
                        ),
                      );
                    }
                  ),
                )
            ],
          ),
        ),
      )
    );
  }
}