// ==================[ALL GLOBALS VARIABLES FILE]==================
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter/material.dart';

// ==================[SETTINGS VARIABLES]==================
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

// ==================[TEAMS VARIABLES]==================

// ==================[SOUNDS]==================
bool soundToggled = true;

// DEFINE SOUNDS HERE
const String tapSound = "sounds/button-press.mp3";
const String optionChoiceSound = "sounds/option-choice.mp3";
const String optionSwitchSound = "sounds/option-switch.mp3";

const String correctAnswerSound = "sounds/correct-answer.mp3";
const String wrongAnswerSound = "sounds/wrong-answer.mp3";

