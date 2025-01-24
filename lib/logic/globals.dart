// ==================[ALL GLOBALS VARIABLES FILE]==================
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart' show rootBundle;

// ==================[GET APP VERSION && BUILD]==================
String appVersion = '';
String buildNumber = '';

Future<void> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
}

const String agreementTextPath = "texts/agreement.txt";
const String authorsTextPath = "texts/authors.txt";
const String rulesTextPath = "texts/rules.txt";

Map<String, String> textFiles = {
  'texts/agreement.txt': '', 
  'texts/authors.txt': '',   
  'texts/rules.txt': '',    
};



// Generic function to load text into the map
Future<void> loadText(String path) async {
  if (textFiles.containsKey(path)) {
    String text = await rootBundle.loadString('assets/$path');
    textFiles[path] = text; // Update the map with the loaded text
  } 
}

// ==================[SETTINGS VARIABLES]==================
const List<String> difSelectionList = ["łatwe", "średnie", "trudne"];
Set<int> aviableDifs = {0};

final List<String> skipSelectionList = ["0", "5", "10", "15", "∞"];
int aviableSkips = 5;

final List<String> timeSelectionList = ["00:10", "1:00", "2:00", "3:00"];
int aviableTime = 120;

final List<int> pointsSelectionList = [10, 20, 30, 40, 50];
int aviablePoints = 20;

String teamAName = "Drużyna I";
String teamBName = "Drużyna II";

List<String> playersA = [];
List<String> playersB = [];

Color teamAColor = TeamColors.teamRedColor; 
Color teamBColor = TeamColors.teamBlueColor; 

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

