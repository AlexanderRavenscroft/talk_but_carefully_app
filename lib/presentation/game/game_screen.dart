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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: Container(
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
            title: Center(
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TeamPointsDisplay(teamPoints: teamA.points, teamColor: teamA.color),
                  TimerWidget(),
                  TeamPointsDisplay(teamPoints: teamB.points, teamColor: teamB.color),
                ],
              ),
            ),
          ),
        ),
      ),
   
      // BODY
     body: Stack(
      alignment: Alignment.center,
      children: [
       Positioned.fill(
        child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return TeamBackground(teamColor: isTeamBTurn ? teamB.color : teamA.color);
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
            if(isTeamBTurn)
            {
              teamB.points++;
              teamB.players[currentTeamBPlayer].points++;
              for (var player in teamB.players) {
                debugPrint("${player.username}: ${player.points} points");
              }
            }
            else{
              teamA.points++;
              teamA.players[currentTeamAPlayer].points++;
              for (var player in teamA.players) {
                debugPrint("${player.username}: ${player.points} points");
              }
            }
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
  if(teamB.players.isNotEmpty) {
    currentTeamBPlayer = (currentTeamBPlayer + 1) % teamB.players.length;
  }
  if(teamA.players.isNotEmpty){
    currentTeamAPlayer = (currentTeamAPlayer + 1) % teamA.players.length;
  }
}
