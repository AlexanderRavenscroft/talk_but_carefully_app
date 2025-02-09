import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/presentation/widgets/game/game_results_widgets.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/presentation/screens/game_settings/game_settings_screen.dart';

//====================[GAME RESULTS SCREEN]====================
class GameResultsScreen extends StatelessWidget {
  const GameResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: winningTeam?.color ?? AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main Results Container
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
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Winning Team Display
                    WinningTeamDisplay(),

                    // Team Points Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ResultsTeamPointsDisplay(
                          displayedText: teamA.points.toString(),
                          textColor: teamA.color,
                        ),
                        ResultsTeamPointsDisplay(
                          displayedText: ':',
                          textColor: AppColors.textColor,
                        ),
                        ResultsTeamPointsDisplay(
                          displayedText: teamB.points.toString(),
                          textColor: teamB.color,
                        ),
                      ],
                    ),

                    // Team Skips Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResultsTeamSkipsDisplay(
                          teamSkips: teamA.skips,
                          iconFirst: true,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                        ResultsTeamSkipsDisplay(
                          teamSkips: teamB.skips,
                          iconFirst: false,
                        ),
                      ],
                    ),

                    // Players Score List Container
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
                          // Team A Players Score List
                          PlayersScoreList(displayedTeam: teamA),

                          // Divider between Team A and Team B
                          Divider(
                            color: AppColors.shadowColor,
                            thickness: 6,
                            height: 0,
                          ),

                          // Team B Players Score List
                          PlayersScoreList(displayedTeam: teamB),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Spacing between main container and buttons
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              // Bottom Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Back to Settings Button
                  ResultsScreenButton(
                    buttonIcon: AppIcons.arrowBack,
                    onPressed: () {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => GameSettingsScreen()));
                      playAudio(GameSounds.tapSound);
                      resetGame();
                    },
                  ),

                  // Victory Horn Button
                  ResultsScreenButton(
                    buttonIcon: AppIcons.hornCall,
                    onPressed: () => playAudio(GameSounds.victoryHornSound),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//====================[/GAME RESULTS SCREEN]====================