// This file contains all global variables including sounds, excluding imported text
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

//==================[SOUNDS]==================
bool soundToggled = true;

const String tapSound = "sounds/button-press.mp3";
const String optionChoiceSound = "sounds/option-choice.mp3";
const String optionSwitchSound = "sounds/option-switch.mp3";

const String correctAnswerSound = "sounds/correct-answer.mp3";
const String wrongAnswerSound = "sounds/wrong-answer.mp3";

//==================[GAME SETTINGS VARIABLES]==================  

//Default values bellow
const List<String> difSelectionList = ["łatwe", "średnie", "trudne"];
Set<int> aviableDifs = {0};           

final List<String> skipSelectionList = ["0", "5", "10", "15", "∞"];
int aviableSkips = 5;                 

final List<String> timeSelectionList = ["00:10", "1:00", "2:00", "3:00"];
int aviableTime = 120;                

final List<int> pointsSelectionList = [10, 20, 30, 40, 50];
int aviablePoints = 20;              

//==================[Team SETTINGS VARIABLES]==================
String teamAName = "Drużyna I";
String teamBName = "Drużyna II";

List<String> playersA = [];
List<String> playersB = [];

final List<Color> colorSelectionList = [
  TeamColors.teamRedColor,
  TeamColors.teamBlueColor,
  TeamColors.teamGreenColor,
  TeamColors.teamPurpleColor,
  TeamColors.teamYellowColor,
];

// Default selected colors for each team (Must match the default indexes)
Color teamAColor = TeamColors.teamRedColor; 
Color teamBColor = TeamColors.teamBlueColor; 

int teamAselectedIndex = 0; 
int teamBselectedIndex = 1;

//==================[GAME VARIABLES]==================
bool isTeamBTurn = false;

int currentGameScreen = 1;

int currentRound = 1;

int currentTeamAPlayer = 0;
int currentTeamBPlayer = 0;

//==================[POINTS VARIABLES]==================
int teamAPoints = 0;
int teamBPoints = 0;

int teamASkips = 0;
int teamBSkips = 0;


