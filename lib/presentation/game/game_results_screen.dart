import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/presentation/game/game_results_screen_widgets.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
class GameResultsScreen extends StatelessWidget {
  const GameResultsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: winningTeam?.color ?? AppColors.primaryColor,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.74,
                width: MediaQuery.of(context).size.width * 0.86,
                decoration: BoxDecoration(
                  color: AppColors.neutralColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(offset: Offset(0, 10), color: AppColors.shadowColor, blurRadius: 1, spreadRadius: 2)]
                ),
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                    (winningTeam==null) ? 
                    'REMIS'
                    : '${winningTeam?.name.toUpperCase()}\nWYGRYWAJĄ',
                    textAlign: TextAlign.center,
                    style: AppTypography.descBoldStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.06,
                      color: winningTeam?.color ?? AppColors.textColor,
                    ),    
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        teamA.points.toString(),
                        style: AppTypography.descBoldStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          color: teamA.color,
                        ),    
                      ),
                      Text(
                        ':',
                        style: AppTypography.descBoldStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          color: AppColors.textColor,
                        ),    
                      ),
                      Text(
                        teamB.points.toString(),
                        style: AppTypography.descBoldStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          color: teamB.color,
                        ),    
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResultsTeamSkipsDisplay(teamSkips: teamA.skips, iconFirst: true),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      ResultsTeamSkipsDisplay(teamSkips: teamB.skips, iconFirst: false),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlayersScoreList(displayedTeam: teamA),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PlayersScoreList(displayedTeam: teamB)
                    ],
                  ),
                 ],
               ),
              ),
                
            ElevatedButton(onPressed: null, child: Text('chuj')),
          ],
        ),
      ),
    );
  }
}