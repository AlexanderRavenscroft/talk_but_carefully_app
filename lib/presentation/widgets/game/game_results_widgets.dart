import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/l10n/lang_fix.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//====================[WINNING TEAM DISPLAY]====================
class WinningTeamDisplay extends StatelessWidget {
  const WinningTeamDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Text(
       (winningTeam == null)
          ? AppLocalizations.of(context)!.draw.toUpper()
          : '${winningTeam?.name.toUpperCase()}\n${AppLocalizations.of(context)!.wins.toUpper()}',
       textAlign: TextAlign.center,
       style:  (winningTeam == null)
         ? AppTypography.descBoldStyle.copyWith(
            height: 1,
            fontSize: MediaQuery.of(context).size.height * 0.05,
            )
        : AppTypography.descBoldStyle.copyWith(
             height: 1,
             fontSize: MediaQuery.of(context).size.height * 0.05,
             foreground: Paint()
              ..style = PaintingStyle.stroke
               ..strokeWidth = 4
               ..color = AppColors.textColor,
           ),
          ),
          Text(
            (winningTeam == null)
              ? AppLocalizations.of(context)!.draw.toUpper()
              :'${winningTeam?.name.toUpperCase()}\n${AppLocalizations.of(context)!.wins.toUpper()}',
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              height: 1,
              fontSize: MediaQuery.of(context).size.height * 0.05,
              color: winningTeam?.color ?? AppColors.textColor,
            ),
          ),
      ],
    );
  }
}
//====================[/WINNING TEAM DISPLAY]====================

//====================[RESULTS TEAM POINTS DISPLAY]====================
class ResultsTeamPointsDisplay extends StatelessWidget {
  final String displayedText;
  final Color textColor;

  const ResultsTeamPointsDisplay({
    super.key,
    required this.displayedText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          displayedText,
          style: AppTypography.descBoldStyle.copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.05,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = AppColors.textColor,
          ),
        ),
                Text(
          displayedText,
          style: AppTypography.descBoldStyle.copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.05,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
//====================[/RESULTS TEAM POINTS DISPLAY]====================

//====================[RESULTS TEAM SKIPS DISPLAY]====================
class ResultsTeamSkipsDisplay extends StatelessWidget {
  final int teamSkips;
  final bool iconFirst;

  const ResultsTeamSkipsDisplay({
    super.key,
    required this.teamSkips,
    this.iconFirst = true,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      AppIcons.arrowCurved,
      size: MediaQuery.of(context).size.height * 0.025,
    );
    final text = Text(
      teamSkips.toString(),
      style: AppTypography.descBoldStyle.copyWith(
        color: AppColors.textColor,
        fontSize: MediaQuery.of(context).size.height * 0.025,
      ),
    );

    return Row(
      children: iconFirst ? [icon, text] : [text, icon],
    );
  }
}
//====================[/RESULTS TEAM SKIPS DISPLAY]====================

//====================[PLAYERS SCORE LIST]====================
class PlayersScoreList extends StatelessWidget {
  final Team displayedTeam;

  const PlayersScoreList({
    super.key,
    required this.displayedTeam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.21,
      width: MediaQuery.of(context).size.width * 0.74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: (displayedTeam.players.isEmpty)
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.noPlayersAdded.capitalize(),
               style: AppTypography.descStyle.copyWith(
                 fontSize: MediaQuery.of(context).size.height * 0.036,
              ),
            ),
           )
         : ListView.builder(
            itemCount: displayedTeam.players.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Player Name
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Center(
                      child: Text(
                        displayedTeam.players[index].username,
                        textAlign: TextAlign.center,
                        style: AppTypography.descStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                  ),

                  // Player Progress Bar
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      backgroundColor: Colors.transparent,
                      color: displayedTeam.color,
                      value: (displayedTeam.points == 0)
                          ? 0
                          : displayedTeam.players[index].points / displayedTeam.points,
                    ),
                  ),

                  // Player Points
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                     displayedTeam.players[index].points.toString(),
                     textAlign: TextAlign.center,
                     style: AppTypography.descStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                   ),
                ],
              );
            },
           ),
    );
  }
}
//====================[/PLAYERS SCORE LIST]====================

//====================[RESULTS SCREEN BUTTON]====================
class ResultsScreenButton extends StatelessWidget {
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const ResultsScreenButton({
    super.key,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.38,
            MediaQuery.of(context).size.height * 0.076,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevation: WidgetStateProperty.all(16.0),
        shadowColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: onPressed,
      child: Center(
        child: Icon(
          buttonIcon,
          color: AppColors.textColor,
          size: MediaQuery.of(context).size.height * 0.054,
        ),
      ),
    );
  }
}
//====================[/RESULTS SCREEN BUTTON]====================