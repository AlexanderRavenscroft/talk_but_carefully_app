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
            // Define a MediaQuery-based font size
            Builder(
              builder: (context) {

                // Reusable method to build styled text widgets
                Widget buildText(String content, {double fontSize = 30}) {
                  return Text(
                    content,
                    style: TextStyle(fontSize: fontSize, color: Colors.white),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText("Selected Difficulties: $aviableDifs"),
                    buildText("Available Skips: $aviableSkips"),
                    buildText("Selected Time: $aviableTime"),
                    buildText("Available Points: $aviablePoints"),
                    buildText("Team A Name: $teamAName"),
                    buildText("Team B Name: $teamBName"),
                    buildText("Team A Players: ${playersA.join(', ')}"),
                    buildText("Team B Players: ${playersB.join(', ')}"),
                    buildText("Team A Color: $teamAselectedIndex"),
                    buildText("Team B Color: $teamBselectedIndex"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}