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

Color teamAColor = TeamColors.teamRedColor; 
Color teamBColor = TeamColors.teamBlueColor; 

List<String> playersA = [];
List<String> playersB = [];

String teamAName = "Drużyna I";
String teamBName = "Dryżyna II";

     int teamAselectedIndex = 0;
     int teamBselectedIndex = 1;

