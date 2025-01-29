// This file contains widgets for Game Screen
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/setup.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';

//====================[TEAM COLOR BACKGROUND]====================
class TeamBackground extends StatefulWidget {
  final Color teamColor;
  const TeamBackground({super.key, required this.teamColor});

  @override
  State<TeamBackground> createState() => TeamBackgroundState();
}

class TeamBackgroundState extends State<TeamBackground> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.teamColor,
    );
  }
}
//====================[/TEAM COLOR BACKGROUND]====================


//====================[TEAM POINTS DISPLAY]====================
class TeamPointsDisplay extends StatelessWidget {
  final int teamPoints;
  final Color teamColor;
  const TeamPointsDisplay({super.key, required this.teamPoints, required this.teamColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      teamPoints.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: teamColor, 
        fontSize:  MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }
}
//====================[/TEAM POINTS DISPLAY]====================


//====================[ROUND TIMER]====================
class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {

  @override
  Widget build(BuildContext context) {
    return Text(
      "12:34",
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize:  MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }
}
//====================[/ROUND TIMER]====================


//====================[TEXT BEFORE QUESTION SCREEN]====================
class PlayerEncounterText extends StatefulWidget {
  const PlayerEncounterText({super.key});

  @override
  State<PlayerEncounterText> createState() => PlayerEncounterTextState();
}

class PlayerEncounterTextState extends State<PlayerEncounterText> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('RUNDA ${currentRound.toString()}', style: AppTypography.descBoldStyle.copyWith(fontSize: 30)),
        Text('TERAZ GRAJĄ: ${isTeamBTurn ? TeamSettings.teamBName : TeamSettings.teamAName}', style: AppTypography.descBoldStyle.copyWith(fontSize: 30)),
        Text(getEncounterMessage(), style: AppTypography.descBoldStyle.copyWith(fontSize: 20)),
        Text(currentGameScreen.toString(), style: AppTypography.descBoldStyle.copyWith(fontSize: 20)),
      ],
    );
  }
}
//====================[/TEXT BEFORE QUESTION SCREEN]====================


//====================[QUESTION CARD SCREEN]====================
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> {

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title \n$forbiddenWords\n$difficulty',
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize:  MediaQuery.of(context).size.height * 0.03,
      ),
    );
  }
}
//====================[/QUESTION CARD SCREEN]====================