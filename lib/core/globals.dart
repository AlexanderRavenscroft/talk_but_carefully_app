// This file contains all global variables including sounds, excluding imported text
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

//==================[SOUNDS]==================
class GameSounds{
  static bool soundToggled = true;

  static const String tapSound = "sounds/button-press.mp3";
  static const String optionChoiceSound = "sounds/option-choice.mp3";
  static const String optionSwitchSound = "sounds/option-switch.mp3";

  static const String correctAnswerSound = "sounds/correct-answer.mp3";
  static const String wrongAnswerSound = "sounds/wrong-answer.mp3";
}

//==================[GAME SETTINGS VARIABLES]==================  
class GameSettings{
  // Default game settings selection (Must match the defualt selectedIndex)
  static Set<int> aviableDifs = {0};           
  static int aviableSkips = 5;                 
  static int aviableTime = 120;                
  static int aviablePoints = 20;        
}

//==================[Team SETTINGS VARIABLES]==================
class TeamSettings{
  static String teamAName = "Drużyna I";
  static String teamBName = "Drużyna II";

  static List<String> teamAPlayers = [];
  static List<String> teamBPlayers = [];

  // Default selected colors for each team (Must match the default indexes)
  static Color teamAColor = TeamColors.teamRedColor; 
  static Color teamBColor = TeamColors.teamBlueColor; 
}

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


