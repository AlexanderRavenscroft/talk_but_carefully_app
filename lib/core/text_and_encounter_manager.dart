// Imports text files and generates dynamic encounter messages.
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:convert';
import 'package:gadajaleostroznie/core/game_logic.dart';

//==================[IMPORT .TXT FILES]==================
Map<String, String> textFiles = {
  'legal_and_info/en/agreement.txt': '', 
  'legal_and_info/en/creator.txt': '',   
  'legal_and_info/en/rules.txt': '',   
  'legal_and_info/pl/agreement.txt': '', 
  'legal_and_info/pl/creator.txt': '',   
  'legal_and_info/pl/rules.txt': '',     
};

Future<void> loadText(String path) async {
  if (textFiles.containsKey(path)) {
    String text = await rootBundle.loadString('assets/$path');
    textFiles[path] = text; // Update the map with the loaded text
  } 
}

//==================[IMPORT .JSON FILES]==================
List<String> playerEncounterList = []; // Load .json files

Future<void> loadEncounterMessages() async {
  String content = await rootBundle.loadString('assets/legal_and_info/en/encounter_messages.json');
  playerEncounterList = List<String>.from(json.decode(content));
  content = await rootBundle.loadString('assets/legal_and_info/pl/encounter_messages.json');
  playerEncounterList = List<String>.from(json.decode(content));
}

String getRandomElement(List<String> list) { // Get random message
  final random = Random();
  int randomIndex = random.nextInt(list.length);
  return list[randomIndex]; 
}

// Generate random message with player or team name
String fullEncounterMessage = '';
String getEncounterMessage() {
  if (currentTeam.players.isEmpty) {
    return '${getRandomElement(playerEncounterList)} ${currentTeam.name}!';
  }

  int index = teamPlayerIndexes[currentTeam]!;  
  return '${getRandomElement(playerEncounterList)} ${currentTeam.players[index].username}!';
}

