import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
class ResultsTeamSkipsDisplay extends StatelessWidget {
  final int teamSkips;
  final bool iconFirst;
  
  const ResultsTeamSkipsDisplay({
    super.key, 
    required this.teamSkips, 
    this.iconFirst = true,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      AppIcons.arrowCurved, 
      size: MediaQuery.of(context).size.height * 0.03,
    );
    final text = Text(
      teamSkips.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize: MediaQuery.of(context).size.height * 0.03,
      ),
    );
    
    return Row(
      children: iconFirst ? [icon, text] : [text, icon],
    );
  }
}

class PlayersScoreList extends StatelessWidget {
  final Team displayedTeam;
  const PlayersScoreList({super.key, required this.displayedTeam});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.74,
            decoration: BoxDecoration(
              color: AppColors.shadowColor,
              borderRadius: BorderRadius.circular(16),
            ),
              child: ListView.builder(
                itemCount: displayedTeam.players.length,
                 itemBuilder: (context, index) {
                   return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                        Container(
                         // color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.3,
                           child: Text(
                            displayedTeam.players[index].username, 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                            )
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.32,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black,
                              color: displayedTeam.color,
                              value: displayedTeam.players[index].points / displayedTeam.points,
                            ),
                          ),
                        ),
                     ],
                   );
                 }
              ),
          )
        ],
      ),
    );
  }
}