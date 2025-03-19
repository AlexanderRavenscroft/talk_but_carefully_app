// Imports text files and generates dynamic encounter messages.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:convert';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:provider/provider.dart';

//==================[IMPORT .TXT FILES]==================
Map<String, String> textFiles = {
  'legal_and_info/en/agreement.txt': '',
  'legal_and_info/en/creator.txt': '',
  'legal_and_info/en/rules.txt': '',
  'legal_and_info/pl/agreement.txt': '',
  'legal_and_info/pl/creator.txt': '',
  'legal_and_info/pl/rules.txt': '',
};

Future<void> loadTextFiles() async {
  for (var path in textFiles.keys) {
    textFiles[path] = await rootBundle.loadString('assets/$path');
  }
}

// ==================[IMPORT .JSON FILES]==================
late List<String> enPlayerEncounterList;
late List<String> plPlayerEncounterList;

final Map<String, List<String>> playerEncounterLists = {};

Future<void> loadEncounterMessages() async {
  for (String locale in ['en', 'pl']) {
    String path = 'assets/legal_and_info/$locale/encounter_messages.json';
    String content = await rootBundle.loadString(path);
    playerEncounterLists[locale] = List<String>.from(json.decode(content));
  }
}

// ==================[GET RANDOM ELEMENT]==================
String getRandomElement(List<String> list) { // Get random message
  final random = Random();
  int randomIndex = random.nextInt(list.length);
  return list[randomIndex]; 
}

// ==================[GET ENCOUNTER MESSAGE]==================
String getEncounterMessage(BuildContext context) {
  String localeCode = Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
  List<String> selectedList = playerEncounterLists[localeCode] ?? enPlayerEncounterList;

  String randomMessage = getRandomElement(selectedList);
  return currentTeam.players.isEmpty
    ? '$randomMessage ${currentTeam.name}!'
    : '$randomMessage ${currentTeam.players[teamPlayerIndexes[currentTeam]!].username}!';
}
