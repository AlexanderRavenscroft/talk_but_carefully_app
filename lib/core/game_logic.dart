import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/setup.dart';

Map<Team, int> teamPlayerIndexes = {
  teamA: 0,
  teamB: 0,
};

String fullEncounterMessage = '';
String getEncounterMessage() {
  if (currentTeam.players.isEmpty) {
    return '${getRandomElement(playerEncounterList)} ${currentTeam.name}!';
  }

  int index = teamPlayerIndexes[currentTeam]!;  // Get the current player index for the team
  return '${getRandomElement(playerEncounterList)} ${currentTeam.players[index].username}!';
}

void assignCurrentPlayer() {
  if (teamA.players.isNotEmpty) {
    teamPlayerIndexes[teamA] = (teamPlayerIndexes[teamA]! + 1) % teamA.players.length;
  }
  if (teamB.players.isNotEmpty) {
    teamPlayerIndexes[teamB] = (teamPlayerIndexes[teamB]! + 1) % teamB.players.length;
  }
}



int test = 0;
void nextScreen() {
  // End of the round
  if(currentScreen == Screen.question) {
    isTeamBTurn = !isTeamBTurn; 
    currentTeam = isTeamBTurn ? teamB : teamA; 
     
  }

  // Start of next the round

test = (test >= 4) ? 1 : test + 1;

if (test == 4) {
  currentRound++;
  assignCurrentPlayer();
}
  debugPrint(test.toString());
  currentScreen = currentScreen == Screen.encounter ? Screen.question : Screen.encounter;
}



   void addPoints() {
    
          currentTeam.points++;

          if (currentTeam.players.isNotEmpty) {
            currentTeam.players[teamPlayerIndexes[currentTeam]!].points++; 
            debugPrint([teamPlayerIndexes[currentTeam]!].toString());
            for (var player in currentTeam.players) {
              debugPrint("${player.username}: ${player.points} points");
            }
          }
}
   void removePoints() {
    
          currentTeam.points--;

          if (currentTeam.players.isNotEmpty) {
            currentTeam.players[teamPlayerIndexes[currentTeam]!].points--; 
            debugPrint([teamPlayerIndexes[currentTeam]!].toString());
            for (var player in currentTeam.players) {
              debugPrint("${player.username}: ${player.points} points");
            }
          }
}