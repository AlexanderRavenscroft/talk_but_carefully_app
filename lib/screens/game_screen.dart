import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
import 'package:gadajaleostroznie/widgets/game_screen_widgets.dart';
import 'package:gadajaleostroznie/logic/provider.dart';
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.accentColor,
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
        Positioned.fill(child:TeamBackground(teamColor:  isTeamBluePlaying ?  teamBColor : teamAColor)),
        Positioned(
          top: 200,
          
          child: ElevatedButton(
            onPressed: () {
              
             // isTeamBluePlaying = !isTeamBluePlaying;
          //    context.read<GameToggleProvider>().toggleTurns();
            }, 
            child: Text(isTeamBluePlaying.toString())
          ),
        ),
      ],
     ),
    );
  }
}