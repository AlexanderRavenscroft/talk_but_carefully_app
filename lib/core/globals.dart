// This file tores global instances of `Game`, `Team`, `Player` classes. 
// As well as Navigator Key.
// Imported across the app for shared state.
import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

//==================[NAVIGATION SERVICE]==================
class NavigationService {
  // Defining this will make easier Navigation between game and game_results_screen
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

//==================[GAME SETTINGS]==================  
class GameSettings{
  // Default game settings selection (Must match the defualt selectedIndex)
  static Set<int> aviableDifs = {0};           
  static int aviableSkips = 5;                 
  static int aviableTime = 120;                
  static int aviablePoints = 20;        
}

//==================[PLAYER AND TEAM CLASSES]==================
class Player{
  final String username;
  int points;

  Player(this.username, this.points);
}

class Team{
  String name;
  final List<Player> players;
  Color color;
  int points;
  int skips;

  Team(this.name, this.players, this.color, this.points, this.skips);
}

//=====================[TEAMS]=====================
final Team teamA = Team("Team I", [], TeamColors.teamRedColor, 0, 0);
final Team teamB = Team("Team II", [], TeamColors.teamBlueColor, 0, 0);
final List<Team> teams = [teamA, teamB];
