// This file contains app version setup, importing .txt and .json assets, generating player encounter message
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:convert';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:package_info_plus/package_info_plus.dart';

//==================[GET APP VERSION && BUILD]==================
String appVersion = '';
String buildNumber = '';

Future<void> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
}

//==================[IMPORT .TXT FILES]==================
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

//==================[IMPORT .JSON FILES]==================
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

// Return the whole message (Empty list avoidence thanks to logical statements)
String fullEncounterMessage = '';
String getEncounterMessage() {
  if (playersA.isEmpty && playersB.isEmpty) {
    fullEncounterMessage = 'OBIE LISTY SĄ PUSTE!';
  } 
  else if(isTeamBTurn){
    if(playersB.isEmpty){
    fullEncounterMessage = '${getRandomElement(playerEncounterList)} $teamBName';
    }
    else{
      fullEncounterMessage= '${getRandomElement(playerEncounterList)} ${isTeamBTurn ? playersB[currentTeamBPlayer] : playersA[currentTeamAPlayer]}!';
    }
  }
  else{
    if(playersA.isEmpty){
    fullEncounterMessage = '${getRandomElement(playerEncounterList)} $teamAName';
    }
    else{
      fullEncounterMessage= '${getRandomElement(playerEncounterList)} ${isTeamBTurn ? playersB[currentTeamBPlayer] : playersA[currentTeamAPlayer]}!';
    }
  }
  return fullEncounterMessage; 
}