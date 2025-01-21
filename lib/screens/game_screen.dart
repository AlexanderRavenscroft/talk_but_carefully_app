import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        toolbarHeight: (MediaQuery.of(context).size.height) * 0.08,
        title: Image.asset(
            'assets/images/logo.png', 
            height: (MediaQuery.of(context).size.height) * 0.07,
            width: (MediaQuery.of(context).size.width) * 0.4,
          ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: (MediaQuery.of(context).size.height) * 0.04),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // BODY
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Difficulties: $selectedDifs",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Available Selections: $aviableSelections",
            style: TextStyle(fontSize:26, color: Colors.white),
          ),
          Text(
            "Selected Time: $selectedTime",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Available Points: $aviablePoints",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Team A Name: $teamAName",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Team B Name: $teamBName",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Team A Players: ${playersA.join(', ')}",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "Team B Players: ${playersB.join(', ')}",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
           Text(
            "Team A Color: $teamAselectedIndex",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            "Team B Color: $teamBselectedIndex",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    ),
    );
  }
}