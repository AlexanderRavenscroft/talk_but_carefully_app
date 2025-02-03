import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/presentation/settings/game_settings_widgets.dart';
import 'package:gadajaleostroznie/presentation/settings/team_settings_screen.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => GameSettingsScreenState();
}



class GameSettingsScreenState extends State<GameSettingsScreen> {


  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (ModalRoute.of(context)!.isCurrent) {
    _resetVariables();
  }
}
    void _resetVariables() {
    setState(() {
                   teamA = Team("Drużyna I", [], TeamColors.teamRedColor, 0, 0);
          teamB = Team("Drużyna II", [], TeamColors.teamBlueColor, 0, 0);
         currentGameStage = 0;
      currentRound = 1;
      teamPlayerIndexes[teamA] = 0;
      teamPlayerIndexes[teamB] = 0;
      isTeamBTurn == false;
currentScreen = Screen.encounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          // APPBAR
          appBar: AppBar(
            backgroundColor: AppColors.accentColor,
            toolbarHeight: (MediaQuery.of(context).size.height) * 0.08,
            title: Image.asset(
                'assets/images/logo.png', 
                height: (MediaQuery.of(context).size.height) * 0.07,
                width: (MediaQuery.of(context).size.width) * 0.4,
              ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: (MediaQuery.of(context).size.height) * 0.04),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          
          // BODY
          body: Stack(
            alignment: Alignment.center,
            children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/background-circles.svg', 
                fit: BoxFit.cover,         
                ),
              ),
        
            Positioned(
              top: (MediaQuery.of(context).size.height) * 0.05,
              child: OptionsSelectionContainer(optionsText: "PYTANIA", selectionWidget: DifSelection()),
            ),
        
            Positioned(
              top: (MediaQuery.of(context).size.height) * 0.23,
              child: OptionsSelectionContainer(optionsText: "DOSTĘPNE POMINIĘCIA", selectionWidget: SkipSelection()),
            ),
        
            Positioned(
              top: (MediaQuery.of(context).size.height) * 0.41,
              child: OptionsSelectionContainer(optionsText: "CZAS RUNDY", selectionWidget: TimeSelection()),
            ),
        
            Positioned(
              top: (MediaQuery.of(context).size.height) * 0.59,
              
              child: OptionsSelectionContainer(optionsText: "LIMIT", selectionWidget: PointsSelection()),
            ),
        
            Positioned(
              top: (MediaQuery.of(context).size.height) * 0.76,
              
              child: NextSettingsButton(nextScreenWidget: TeamSettingsScreen()),
            ),
            ],
          ),
        );
  }
}
