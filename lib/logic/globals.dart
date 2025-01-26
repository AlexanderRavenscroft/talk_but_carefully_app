//==================[ALL GLOBALS VARIABLES FILE]==================
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:convert';

//==================[GET APP VERSION && BUILD]==================
String appVersion = '';
String buildNumber = '';

Future<void> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
}

//==================[IMPORT TXT.FILES]==================
// Scrollable text:
Map<String, String> textFiles = {
  'texts/agreement.txt': '', 
  'texts/authors.txt': '',   
  'texts/rules.txt': '',    
};
Future<void> loadText(String path) async {
  if (textFiles.containsKey(path)) {
    String text = await rootBundle.loadString('assets/$path');
    textFiles[path] = text; // Update the map with the loaded text
  } 
}

// Random Encounter Messages from .json
List<String> playerEncounterList = [];
Future<void> loadEncounterMessages() async {
  final String content = await rootBundle.loadString('assets/texts/playerEncounterMessages.json');
  playerEncounterList = List<String>.from(json.decode(content));
}
String getRandomElement(List<String> list) {
  final random = Random();
  int randomIndex = random.nextInt(list.length);
  return list[randomIndex]; 
}

// Return the whole message (Empty list avoidence thanks to Logical statements)
String fullEncounterMessage = '';
String getEncounterMessage() {
  if (playersA.isEmpty && playersB.isEmpty) {
    fullEncounterMessage = 'OBIE LISTY SĄ PUSTE!';
  } 
  else if(isTeamBlueTurn){
    if(playersB.isEmpty){
    fullEncounterMessage = '${getRandomElement(playerEncounterList)} $teamBName';
    }
    else{
      fullEncounterMessage= '${getRandomElement(playerEncounterList)} ${isTeamBlueTurn ? playersB[currentTeamBPlayer] : playersA[currentTeamAPlayer]}!';
    }
  }
  else{
    if(playersA.isEmpty){
    fullEncounterMessage = '${getRandomElement(playerEncounterList)} $teamAName';
    }
    else{
      fullEncounterMessage= '${getRandomElement(playerEncounterList)} ${isTeamBlueTurn ? playersB[currentTeamBPlayer] : playersA[currentTeamAPlayer]}!';
    }
  }
  return fullEncounterMessage; 
}

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
bool isTeamBlueTurn = false;
int currentGameScreen = 1;

int currentRound = 1;

int currentTeamAPlayer = 0;
int currentTeamBPlayer = 0;

void assignCurrentPlayers() {
  if(playersB.isNotEmpty)
  {
  currentTeamBPlayer = (currentTeamBPlayer + 1) % playersB.length;
  }
  if(playersA.isNotEmpty)
  {
    currentTeamAPlayer = (currentTeamAPlayer + 1) % playersA.length;
  }
}

//==================[POINTS VARIABLES]==================
int teamAPoints = 0;
int teamBPoints = 0;

int teamASkips = 0;
int teamBSkips = 0;


