import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/presentation/game/game_results_screen_widgets.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

class GameResultsScreen extends StatelessWidget {
  const GameResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: winningTeam?.color ?? AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.74,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: AppColors.neutralColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.black,
                        blurRadius: 6,
                        spreadRadius: 0)
                  ]
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (winningTeam == null)
                        ? 'REMIS'
                        : '${winningTeam?.name.toUpperCase()}\nWYGRYWAJĄ',
                    textAlign: TextAlign.center,
                    style: AppTypography.descBoldStyle.copyWith(
                      height: 1,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      color: winningTeam?.color ?? AppColors.textColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ResultsTeamPointsDisplay(displayedText: teamA.points.toString(), textColor: teamA.color),
                      ResultsTeamPointsDisplay(displayedText: ':', textColor: AppColors.textColor),
                      ResultsTeamPointsDisplay(displayedText: teamB.points.toString(), textColor: teamB.color),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResultsTeamSkipsDisplay(
                          teamSkips: teamA.skips, iconFirst: true),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      ResultsTeamSkipsDisplay(
                          teamSkips: teamB.skips, iconFirst: false),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.46,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        strokeAlign: BorderSide.strokeAlignInside,
                        color: AppColors.textColor,
                        width: 6,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayersScoreList(displayedTeam: teamA),
                        Divider(
                          color: AppColors.shadowColor, 
                          thickness: 6, 
                        ),
                        PlayersScoreList(displayedTeam: teamB)
                      ],
                    ),
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
