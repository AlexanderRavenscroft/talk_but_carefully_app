import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/logic/globals.dart';

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
        fontSize:  MediaQuery.of(context).size.height * 0.06),
    );
  }
}

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
        fontSize:  MediaQuery.of(context).size.height * 0.06),
    );
  }
}