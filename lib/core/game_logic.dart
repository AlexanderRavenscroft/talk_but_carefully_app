import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/setup.dart';
import 'package:gadajaleostroznie/presentation/game/game_results_screen.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
Map<Team, int> teamPlayerIndexes = {
  teamA: 0,
  teamB: 0,
};

String fullEncounterMessage = '';
String getEncounterMessage() {
  if (currentTeam.players.isEmpty) {
    return '${getRandomElement(playerEncounterList)} ${currentTeam.name}!';
  }

  int index = teamPlayerIndexes[currentTeam]!;  
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

enum Screen {encounter, question}
Screen currentScreen = Screen.encounter;

bool isTeamBTurn = false;
Team currentTeam = teamA;

int currentGameStage = 0;
int currentRound = 1;

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

// POINTS BUTTONS FUNCTIONS
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

// END OF THE GAME
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
    playAudio(GameSounds.winningSound);
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => GameResultsScreen()));
    return true;
  }
  return false;
}

// RESET GAME
void resetGame() {
  // Keep the Teams and players, reset and screen
  for (var team in teams) {
    team.points = 0;
    team.skips = 0;
  }
  for (Team team in teams) {
    for (Player player in team.players) {
      player.points = 0;
    }
  }

  currentGameStage = 0;
  currentRound = 1;
  teamPlayerIndexes[teamA] = 0;
  teamPlayerIndexes[teamB] = 0;
  currentScreen = Screen.encounter;
  currentTeam = teamA;
  isTeamBTurn = false;
}