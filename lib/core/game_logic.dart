import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/setup.dart';
import 'package:gadajaleostroznie/presentation/game/game_results_screen.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
Map<Team, int> teamPlayerIndexes = {
  teamA: 0,
  teamB: 0,
};

String fullEncounterMessage = '';
String getEncounterMessage() {
  if (currentTeam.players.isEmpty) {
    return '${getRandomElement(playerEncounterList)} ${currentTeam.name}!';
    // return 'No dalej, nie każ nam czekać wieczność ${currentTeam.name}!';
  }

  int index = teamPlayerIndexes[currentTeam]!;  
  return '${getRandomElement(playerEncounterList)} ${currentTeam.players[index].username}!';
  //  return 'No dalej, nie każ nam czekać wieczność ${currentTeam.players[index].username}!';
}

void assignCurrentPlayer() {
  if (teamA.players.isNotEmpty) {
    teamPlayerIndexes[teamA] = (teamPlayerIndexes[teamA]! + 1) % teamA.players.length;
  }
  if (teamB.players.isNotEmpty) {
    teamPlayerIndexes[teamB] = (teamPlayerIndexes[teamB]! + 1) % teamB.players.length;
  }
}

int currentGameStage = 0;
void nextScreen() {
  // Half of the round
  if(currentScreen == Screen.question) {
    isTeamBTurn = !isTeamBTurn; 
    currentTeam = isTeamBTurn ? teamB : teamA; 
     
  }

  currentGameStage = (currentGameStage >= 4) ? 1 : currentGameStage + 1;

  // Start of next the round
  if (currentGameStage == 4) {
    checkResults();
    bool isGameOver = checkResults();
    if(isGameOver)
    {
      return; //We return early, if the Game is Over
    }
    else
    {
      currentRound++;
      assignCurrentPlayer();
    }
  }
  
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
  }
}

void addSkips() {
  currentTeam.skips++;
}

Team? winningTeam = teamA;

checkResults() {
  if(teams.any((team) => team.points >= GameSettings.aviablePoints)) {
    if(teamA.points > teamB.points) {
      winningTeam = teamA;
    }
    else if(teamB.points > teamA.points) {
      winningTeam = teamB;
    }
    else {
      if(teamA.skips > teamB.skips) {
        winningTeam = teamB;
      }
      else if(teamB.skips > teamA.skips) {
        winningTeam = teamA;
      }
      else {
     winningTeam = null;
      }
    }
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => GameResultsScreen()));
    return true;
  }
  return false;
}
void resetGame() {
  // Keep the Teams and players, reset points

  // teamA = Team("Drużyna I", [], TeamColors.teamRedColor, 0, 0);
  // teamB = Team("Drużyna II", [], TeamColors.teamBlueColor, 0, 0);
  for (var team in teams) {
    team.points = 0;
    team.skips = 0;
  }
  currentGameStage = 0;
  currentRound = 1;
  teamPlayerIndexes[teamA] = 0;
  teamPlayerIndexes[teamB] = 0;
  currentScreen = Screen.encounter;
  currentTeam = teamA;
  isTeamBTurn = false;
}
