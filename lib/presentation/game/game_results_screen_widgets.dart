import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';

class ResultsTeamPointsDisplay extends StatelessWidget {
  final String displayedText;
  final Color textColor;
  const ResultsTeamPointsDisplay({super.key, required this.displayedText, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: AppTypography.descBoldStyle.copyWith(
        fontSize: MediaQuery.of(context).size.height * 0.05,
        color: textColor,
      ),
    );
  }
}



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
      size: MediaQuery.of(context).size.height * 0.025,
    );
    final text = Text(
      teamSkips.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize: MediaQuery.of(context).size.height * 0.025,
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
    return Container(
            height: MediaQuery.of(context).size.height * 0.21,
            width: MediaQuery.of(context).size.width * 0.74,
            decoration: BoxDecoration(
         //    color: AppColors.shadowColor,
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
                     //   color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.3,
                           child: Center(
                             child: Text(
                              displayedTeam.players[index].username, 
                              textAlign: TextAlign.center,
                              style: AppTypography.descStyle.copyWith(
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                              ),
                             ),
                           ),
                        ),

                         SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.36,
                            child: LinearProgressIndicator(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                              backgroundColor: Colors.transparent,
                              color: displayedTeam.color,
                              value: displayedTeam.players[index].points / displayedTeam.points,
                            ),
                          ),
                    ],
                 );
               }
          ),
        );

  }
}