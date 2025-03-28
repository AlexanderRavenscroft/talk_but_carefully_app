import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/l10n/lang_fix.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/text_and_encounter.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/core/providers/ui_providers.dart';
import 'package:gadajaleostroznie/core/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//====================[GAME APP BAR]====================
class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
//====================[/GAME APP BAR]====================

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
  late TimerProvider _timerProvider; // Store reference

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timerProvider = Provider.of<TimerProvider>(context, listen: false);
   
  }

  @override
  void dispose() {
    _timerProvider.stopTimer(reset: true); // Use stored reference to cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        return Text(
          '${(timerProvider.timeLeft ~/ 60)}:${(timerProvider.timeLeft % 60).toString().padLeft(2, '0')}',
          style: AppTypography.descBoldStyle.copyWith(
            color: AppColors.textColor,
            fontSize: MediaQuery.of(context).size.height * 0.06,
          ),
        );
      }
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
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.5,
          child: LinearProgressIndicator(
            backgroundColor: AppColors.shadowColor,
            color: AppColors.notificationColor,
            value: timerProvider.timeLeft / GameSettings.aviableTime,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
        );
      }
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
                '${AppLocalizations.of(context)!.round.capitalize()} ${currentRound.toString()}',
                textAlign: TextAlign.center,
                style: AppTypography.descBoldStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                '${AppLocalizations.of(context)!.guessingTeam.toUpper()}:',
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
                getEncounterMessage(context),
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
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: AppColors.shadowColor,
              blurRadius: 1,
              spreadRadius: 2,
            ),
          ],
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
                  difficulty == 'easy'
                      ? AppIcons.easyDiff
                      : difficulty == 'medium'
                          ? AppIcons.mediumDiff
                          : AppIcons.hardDiff,
                  size: MediaQuery.of(context).size.height * 0.06,
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
        playAudio(GameSounds.tapSound);
        await fetchData(Provider.of<LocaleProvider>(context, listen: false).locale.languageCode);
        nextScreen();
        if (context.mounted) {
          Provider.of<TimerProvider>(context, listen: false).setTimeLeft(GameSettings.aviableTime);
          Provider.of<TimerProvider>(context, listen: false).startTimer();
          Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
        }    
      },
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.start.capitalize(),
          style: AppTypography.buttonStyle.copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.05,
          ),
        ),
      ),
    );
  }
}
//====================[/START A ROUND BUTTON]====================

//====================[POINTS BUTTON]====================
class PointsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData buttonIcon;
  final Color iconColor;

  const PointsButton({
    super.key,
    required this.onPressed,
    required this.buttonIcon,
    required this.iconColor,
  });

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
//====================[/POINTS BUTTON]====================

//====================[DATA LOADING INDICATOR]====================
class DataLoadingIndicator extends StatefulWidget {
  const DataLoadingIndicator({super.key});

  @override
  State<DataLoadingIndicator> createState() => _DataLoadingIndicatorState();
}

class _DataLoadingIndicatorState extends State<DataLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Center(
        child: FractionallySizedBox(
          heightFactor: 0.25,
          child: AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              child: CircularProgressIndicator(
                color: AppColors.neutralColor,
                strokeWidth: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//====================[/DATA LOADING INDICATOR]====================