import 'package:flutter/material.dart';
import 'package:mlb_roster/models/roster_model.dart';
import 'package:provider/provider.dart';
import 'package:mlb_roster/providers/roster_provider.dart';
import 'roster_screen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RosterProvider>().fetchTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RosterProvider>(context);
    final List<TeamModel> teams = provider.teams;
    teams.sort((a, b) => a.teamName.compareTo(b.teamName));

    if (provider.errorMessage != null && provider.errorMessage!.isNotEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(provider.errorMessage!),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Team",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),

              SizedBox(height: 24,),

              Expanded(
                child: ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final TeamModel team = teams[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RosterScreen(team: team)
                          )
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: team.teamLogo,
                          ),
                          title: Text(team.teamName),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}