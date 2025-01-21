// ==================[PUBLIC LIABRY OF GLOBALS]==================
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter/material.dart';

Set<int> selectedDifs = {0};

int aviableSelections = 5;

int selectedTime = 120;

int aviablePoints = 20;

Color teamAColor = TeamColors.teamRedColor; 
Color teamBColor = TeamColors.teamBlueColor; 

List<String> playersA = [];
List<String> playersB = [];

String teamAName = "Drużyna I";
String teamBName = "Drużyna II";

int teamAselectedIndex = 0;
int teamBselectedIndex = 1;

bool soundToggled = true;