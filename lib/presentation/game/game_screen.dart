import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/presentation/game/game_screen_widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textColor,
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.12,
                backgroundColor: AppColors.neutralColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Team A Points
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.04,
                        child: TeamPointsDisplay(teamPoints: teamA.points, teamColor: teamA.color),
                      ),

                      // Team A Skips
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        left: MediaQuery.of(context).size.width * 0.01,
                        child: TeamSkipsDisplay(teamSkips: teamA.skips, iconFirst: true),
                      ),

                      // TIMER 
                      Positioned(
                        child: TimerWidget(),
                      ),

                      // Progress Bar
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        child: ProgressBarWidget(),
                      ),

                      // Team B Points
                      Positioned(
                        right: MediaQuery.of(context).size.width * 0.04,
                        child: TeamPointsDisplay(teamPoints: teamB.points, teamColor: teamB.color),
                      ),

                      // Team B Skips
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        right: MediaQuery.of(context).size.width * 0.01,
                        child: TeamSkipsDisplay(teamSkips: teamB.skips, iconFirst: false),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // BODY
      body: Stack(
        children: [
          // Background
          Consumer<GameToggleProvider>(
            builder: (context, gameToggleProvider, child) {
              return TeamBackground();
            },
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Player Encounter or Question Screen
                Consumer<GameToggleProvider>(
                  builder: (context, gameToggleProvider, child) {
                    return (currentScreen == Screen.encounter)
                        ? PlayerEncounterText()
                        : QuestionScreen();
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                // Round Start Button
                Consumer<GameToggleProvider>(
                  builder: (context, gameToggleProvider, child) {
                    return (currentScreen == Screen.encounter)
                      ? RoundStartButton()
                      : SizedBox.shrink();
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Remove Points Button
                    Consumer<GameToggleProvider>(
                      builder: (context, gameToggleProvider, child) {
                        return (currentScreen == Screen.question)
                         ? PointsButton(
                            onPressed: () {
                               removePoints();
                               fetchData();
                               Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                            }, buttonIcon: Icons.remove, iconColor: AppColors.primaryColor,
                          )
                        : SizedBox.shrink();
                      },
                    ),
                    
                    // Add Points Button
                    Consumer<GameToggleProvider>(
                      builder: (context, gameToggleProvider, child) {
                        return (currentScreen == Screen.question)
                         ? PointsButton(
                            onPressed: () {
                               addSkips();
                               fetchData();
                               Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                            }, buttonIcon: AppIcons.arrowsCcw, iconColor: AppColors.textColor,
                          )
                        : SizedBox.shrink();
                      },
                    ),
                    
                    // Add Points Button
                    Consumer<GameToggleProvider>(
                      builder: (context, gameToggleProvider, child) {
                        return (currentScreen == Screen.question)
                         ? PointsButton(
                            onPressed: () {
                               addPoints();
                               fetchData();
                               Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                            }, buttonIcon: Icons.add, iconColor: AppColors.notificationColor,
                          )
                        : SizedBox.shrink();
                      },
                    ),
                  ],
                ),
             
              ],
            ),
          ),

          // TYMCZASOWY KEBAB
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left:  MediaQuery.of(context).size.width * 0.35,
            child: Consumer<GameToggleProvider>(
              builder: (context, gameToggleProvider, child) {
                 return (currentScreen == Screen.question)
                    ? ElevatedButton(
                        onPressed: () async {
                          await fetchData();
                          nextScreen();
                          if (context.mounted) {
                            Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                          }
                        },
                         child: Icon(Icons.kebab_dining, size: 60),
                       )
                     : SizedBox.shrink();
               },
            ),
          ),
        ],
      ),
    );
  }
}
