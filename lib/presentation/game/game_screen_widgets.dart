// This file contains widgets for Game Screen
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:provider/provider.dart';
//====================[TEAM COLOR BACKGROUND]====================
class TeamBackground extends StatefulWidget {
 const TeamBackground({super.key});

  @override
  State<TeamBackground> createState() => TeamBackgroundState();
}

class TeamBackgroundState extends State<TeamBackground> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentTeam.color,
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

class TeamSkipsDisplay extends StatelessWidget {
  final int teamSkips;
  final bool iconFirst;
  const TeamSkipsDisplay({super.key, required this.teamSkips, this.iconFirst = true});

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      AppIcons.arrowCurved, size: MediaQuery.of(context).size.height * 0.03
    );
    final text = Text(
      teamSkips.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize:  MediaQuery.of(context).size.height * 0.03,
      ),
    );
    
    return Row(
      children: iconFirst ? [icon, text] : [text, icon],
    );
  }
}


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


class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03, 
      width: MediaQuery.of(context).size.width * 0.5, 
      child: Container(
        color: AppColors.notificationColor,
      ),
    );
  }
}






//====================[TEXT BEFORE QUESTION SCREEN]====================
class PlayerEncounterText extends StatefulWidget {
  const PlayerEncounterText({super.key});

  @override
  State<PlayerEncounterText> createState() => PlayerEncounterTextState();
}

class PlayerEncounterTextState extends State<PlayerEncounterText> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Runda ${currentRound.toString()}', 
            style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.08)
          ),
         SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'ODGADUJE DRUŻYNA:', 
            style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.034)
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            isTeamBTurn ? teamB.name.toUpperCase() : teamA.name.toUpperCase(), 
            style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.05)
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            getEncounterMessage(), 
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.034, )
          ),
        ],
      ),
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
      '$title \n\n${forbiddenWords.join('\n')}\n\n$difficulty',
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize:  MediaQuery.of(context).size.height * 0.03,
      ),
    );
  }
}
//====================[/QUESTION CARD SCREEN]====================

class RoundStartButton extends StatelessWidget {
  const RoundStartButton({super.key});

  @override
Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(
          MediaQuery.of(context).size.width * 0.6,
          MediaQuery.of(context).size.height * 0.1,
        )),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
        elevation: WidgetStateProperty.all(14.0),
        shadowColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed:             () {
                        
                         Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                nextScreen();
  Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
               
              },
      child:Center(
              child: Text(
                'START',
                style: AppTypography.buttonStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                
              ),
            ),
        
      ),
    );
  }
}