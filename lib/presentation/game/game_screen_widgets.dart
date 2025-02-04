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
  
  const TeamPointsDisplay({
    super.key, 
    required this.teamPoints, 
    required this.teamColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      teamPoints.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: teamColor, 
        fontSize: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }
}
//====================[/TEAM POINTS DISPLAY]====================

//====================[TEAM SKIPS DISPLAY]====================
class TeamSkipsDisplay extends StatelessWidget {
  final int teamSkips;
  final bool iconFirst;
  
  const TeamSkipsDisplay({
    super.key, 
    required this.teamSkips, 
    this.iconFirst = true,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      AppIcons.arrowCurved, 
      size: MediaQuery.of(context).size.height * 0.03,
    );
    final text = Text(
      teamSkips.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor, 
        fontSize: MediaQuery.of(context).size.height * 0.03,
      ),
    );
    
    return Row(
      children: iconFirst ? [icon, text] : [text, icon],
    );
  }
}
//====================[/TEAM SKIPS DISPLAY]====================

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
        fontSize: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }
}
//====================[/ROUND TIMER]====================

//====================[PROGRESS BAR]====================
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
//====================[/PROGRESS BAR]====================

//====================[TEXT BEFORE QUESTION SCREEN]====================
class PlayerEncounterText extends StatefulWidget {
  const PlayerEncounterText({super.key});

  @override
  State<PlayerEncounterText> createState() => PlayerEncounterTextState();
}

class PlayerEncounterTextState extends State<PlayerEncounterText> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameToggleProvider>(
      builder: (context, gameToggleProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Runda ${currentRound.toString()}', 
                textAlign: TextAlign.center,
                style: AppTypography.descBoldStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'ODGADUJE DRUŻYNA:', 
                textAlign: TextAlign.center,
                style: AppTypography.descBoldStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.034,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                currentTeam.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTypography.descBoldStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.046,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                getEncounterMessage(), 
                textAlign: TextAlign.center,
                style: AppTypography.descBoldStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.034,
                ),
              ),
            ],
          ),
        );
      },
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
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: AppColors.neutralColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(offset: Offset(0, 10), color: AppColors.shadowColor, blurRadius: 1, spreadRadius: 2)],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: AppTypography.descBoldStyle.copyWith(
                          color: AppColors.textColor, 
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                     Text(
                        forbiddenWords.join('\n').toLowerCase(),
                        textAlign: TextAlign.center,
                        style: AppTypography.descBoldStyle.copyWith(
                          color: AppColors.secondTextColor,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.42,
                left: MediaQuery.of(context).size.width * 0.6,
                child: Icon(
                  difficulty=='łatwe' 
                   ? Icons.tag_faces_rounded:
                      difficulty=='średnie'  
                      ? Icons.star_half
                      : Icons.kebab_dining,
                  size:  MediaQuery.of(context).size.height * 0.06,
                  color: AppColors.secondTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//====================[/QUESTION CARD SCREEN]====================

//====================[START A ROUND BUTTON]====================
class RoundStartButton extends StatelessWidget {
  const RoundStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.6,
            MediaQuery.of(context).size.height * 0.1,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        elevation: WidgetStateProperty.all(14.0),
        shadowColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: () async {
        await fetchData(); 
        nextScreen(); 
        if (context.mounted) {
          Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
        }
      },
      child: Center(
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
//====================[/START A ROUND BUTTON]====================

class PointsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData buttonIcon;
  final Color iconColor;
  
  const PointsButton({super.key, required this.onPressed, required this.buttonIcon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.28,
            MediaQuery.of(context).size.height * 0.08,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: WidgetStateProperty.all(8.0),
        shadowColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: onPressed,
      child: Center(
        child: Icon(
          buttonIcon,
          color: iconColor,
          size: MediaQuery.of(context).size.height * 0.07,
        ),
      ),
    );
  }
}


class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameToggleProvider>(
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
          );
  }
}