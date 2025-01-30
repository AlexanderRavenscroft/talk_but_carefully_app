import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
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
        );
      },
    ),
  ),
   
      // BODY
     body: Stack(
      alignment: Alignment.center,
      children: [
       Positioned.fill(
        child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return TeamBackground();
          },
        ),
        ),
       Positioned(
        top: 400,
        child: ElevatedButton(
          onPressed: () {
            
            nextScreen();
            Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
          },
          child: Icon(Icons.arrow_forward_sharp,size: 40),
        ),
      ),
      Center(child: Consumer<GameToggleProvider>(
          builder: (context, gameToggleProvider, child) {
            return (currentScreen == Screen.encounter) 
            ? PlayerEncounterText()
            : QuestionScreen();
          },
        ),
      ),
       Positioned(
        top: 520,
        child: ElevatedButton(
         onPressed: () {
addPoints();
        },
          child: Icon(Icons.plus_one,size: 40),
        ),
      ),
             Positioned(
        top: 590,
        child: ElevatedButton(
         onPressed: () {
removePoints();
        },
          child: Icon(Icons.exposure_minus_1_outlined,size: 40),
        ),
      ),
      ],
     ),
    );
  }
}
