import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
class GameResultsScreen extends StatelessWidget {
  const GameResultsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: Text(winningTeam, style: TextStyle(fontSize: 100))),
    );
  }
}