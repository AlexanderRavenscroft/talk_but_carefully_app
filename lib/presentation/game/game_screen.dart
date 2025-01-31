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
                    blurRadius: 10,
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
                        child:  TeamPointsDisplay(teamPoints: teamA.points, teamColor: teamA.color),
                      ),

                      // Team A Skips
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        left: MediaQuery.of(context).size.width * 0.01,
                        child:  TeamSkipsDisplay(teamSkips: teamA.skips,  iconFirst: true),
                      ),

                      // TIMER 
                      Positioned(
                        child:  TimerWidget(),
                      ),

                      // Progress Bar
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        child: ProgressBarWidget()
                      ),

                      // Team B Points
                      Positioned(
                        right: MediaQuery.of(context).size.width * 0.04,
                        child:   TeamPointsDisplay(teamPoints: teamB.points, teamColor: teamB.color),
                      ),

                      // Team B Skips
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.074,
                        right: MediaQuery.of(context).size.width * 0.01,
                        child:  TeamSkipsDisplay(teamSkips: teamB.skips, iconFirst: false),
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
        alignment: Alignment.center,
        children: [
          // Background
          Positioned.fill(
            child: Consumer<GameToggleProvider>(
              builder: (context, gameToggleProvider, child) {
                return TeamBackground();
              },
            ),
          ),

          // Next Screen Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: ElevatedButton(
              onPressed: () {
                nextScreen();
                Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
              },
              child: Icon(Icons.arrow_forward_sharp, size: 40),
            ),
          ),

          // Main Content (Encounter or Question Screen)
          Center(
            child: Consumer<GameToggleProvider>(
              builder: (context, gameToggleProvider, child) {
                return (currentScreen == Screen.encounter) 
                  ? PlayerEncounterText() 
                  : QuestionScreen();
              },
            ),
          ),

          // Add Points Button
          // Positioned(
          //   top: 520,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       addPoints();
          //       fetchData();
          //       Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                
          //     },
          //     child: Icon(Icons.plus_one, size: 40),
          //   ),
          // ),

          // // Remove Points Button
          // Positioned(
          //   top: 590,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       removePoints();
          //       fetchData();
          //       Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();   
          //     },
          //     child: Icon(Icons.exposure_minus_1_outlined, size: 40),
          //   ),
          // ),
        ],
      ),
    );
  }
}
