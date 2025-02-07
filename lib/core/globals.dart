// This file contains all global variables including sounds, excluding imported text
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

//==================[GLOBAL NAVIGATION KEY]==================
// Defining this will make easier Navigation between game and game_results_screen
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



//==================[GAME SETTINGS VARIABLES]==================  
class GameSettings{
  // Default game settings selection (Must match the defualt selectedIndex)
  static Set<int> aviableDifs = {0};           
  static int aviableSkips = 5;                 
  static int aviableTime = 120;                
  static int aviablePoints = 20;        
}

//==================[Team SETTINGS VARIABLES]==================
class Player{
  String username;
  int points;

  Player(this.username, this.points);
  

}

class Team{
  String name;
  List<Player> players;
  Color color;
  int points;
  int skips;

  Team(this.name, this.players, this.color, this.points, this.skips);
}

List<Team> teams = [
    teamA,
    teamB,
];
Team teamA = Team("Drużyna I", [], TeamColors.teamRedColor, 0, 0);
Team teamB = Team("Drużyna II", [], TeamColors.teamBlueColor, 0, 0);

//==================[GAME VARIABLES]==================


int currentRound = 1;


enum Screen {encounter, question}
Screen currentScreen = Screen.encounter;
 bool isTeamBTurn = false;
Team currentTeam = teamA;

