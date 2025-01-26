import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
import 'package:gadajaleostroznie/widgets/game_screen_widgets.dart';
import 'package:gadajaleostroznie/logic/provider.dart';
import 'package:provider/provider.dart';
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.neutralColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TeamPointsDisplay(teamPoints: teamAPoints, teamColor: teamAColor),
            TimerWidget(),
            TeamPointsDisplay(teamPoints: teamBPoints,teamColor: teamBColor),
          ],
        ),
      ),
      // BODY
     body: Stack(
      alignment: Alignment.center,
      children: [
       Positioned.fill(
        child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return TeamBackground(teamColor: isTeamBlueTurn ? teamBColor : teamAColor,);
          },
        ),
        ),
       Positioned(
        top: 200,
        child: ElevatedButton(
          onPressed: () {
            Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
            currentGameScreen++;
            if(currentGameScreen == 2 || currentGameScreen == 4)
            {
              isTeamBlueTurn = !isTeamBlueTurn;     
              
                          
            }
            // End of turn
            if(currentGameScreen > 4)
            { 
              assignCurrentPlayers();
              currentGameScreen = 1;
              currentRound++;
            }
          },
          child: null
        ),
      ),
      Center(child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return (currentGameScreen==1 || currentGameScreen==3) 
            ? PlayerEncounterText()
            : QuestionScreen();
          },
        ),
      ),
      ],
     ),
    );
  }
}