// ==================[PUBLIC LIABRY OF GLOBALS]==================
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter/material.dart';
Set<int> selectedDifs = {0};

int aviableSelections = 5;

int selectedTime = 120;

int aviablePoints = 20;

var colors = {
  TeamColors.teamRedColor: TeamColors.teamRedMatchingColor,
  TeamColors.teamBlueColor: TeamColors.teamBlueMatchingColor,
  TeamColors.teamGreenColor: TeamColors.teamGreenMatchingColor,
  TeamColors.teamYellowColor: TeamColors.teamYellowMatchingColor,
  TeamColors.teamPurpleColor: TeamColors.teamPurpleMatchingColor,
};

Color teamAColor = const Color(0xFFEB545D); // Default Team A Color
Color teamBColor = const Color(0xFF62BAF3); // Default Team B Color
