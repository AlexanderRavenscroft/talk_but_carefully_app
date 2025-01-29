import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:gadajaleostroznie/presentation/game/game_screen_widgets.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
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
            TeamPointsDisplay(teamPoints: teamAPoints, teamColor: TeamSettings.teamAColor),
            TimerWidget(),
            TeamPointsDisplay(teamPoints: teamBPoints,teamColor: TeamSettings.teamBColor),
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
            return TeamBackground(teamColor: isTeamBTurn ? TeamSettings.teamBColor : TeamSettings.teamAColor,);
          },
        ),
        ),
       Positioned(
        top: 200,
        child: ElevatedButton(
          onPressed: () {
            fetchData();
            Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
            currentGameScreen++;
            if(currentGameScreen == 2 || currentGameScreen == 4)
            {
              isTeamBTurn = !isTeamBTurn;     
              
                          
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
       Positioned(
        top: 400,
        child: ElevatedButton(
          onPressed: () {

          },
          child: null
        ),
      ),
      ],
     ),
    );
  }
}
void assignCurrentPlayers() {
  if(TeamSettings.teamBPlayers.isNotEmpty) {
    currentTeamBPlayer = (currentTeamBPlayer + 1) % TeamSettings.teamBPlayers.length;
  }
  if(TeamSettings.teamAPlayers.isNotEmpty){
    currentTeamAPlayer = (currentTeamAPlayer + 1) % TeamSettings.teamAPlayers.length;
  }
}
