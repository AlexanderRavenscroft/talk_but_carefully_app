import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/themes/globals.dart';
import 'package:gadajaleostroznie/widgets/game_settings_widgets.dart';
import 'package:gadajaleostroznie/screens/game_screen.dart';
import 'package:gadajaleostroznie/widgets/team_settings_widgets.dart';

class TeamSettingsScreen extends StatefulWidget {
  const TeamSettingsScreen({super.key});

  @override
  State<TeamSettingsScreen> createState() => TeamSettingsScreenState();
}

class TeamSettingsScreenState extends State<TeamSettingsScreen> {
  TextEditingController teamAController = TextEditingController(text: teamAName);
  TextEditingController teamBController = TextEditingController(text: teamBName);

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
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColor,
            size: (MediaQuery.of(context).size.height) * 0.04,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // BODY
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: ColorBG(),
          ),
          
          // Team settings container
          Positioned(
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Team A name input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    child: TeamNameTextArea(
                      controller: teamAController,
                      onChanged: (newText) {
                        setState(() {
                          teamAName = newText;
                        });
                      },
                    ),
                  ),
                  
                  TeamSwitch(),
                  
                  // Team B name input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    child: TeamNameTextArea(
                      controller: teamBController,
                      onChanged: (newText) {
                        setState(() {
                          teamBName = newText;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Color selection container
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: (MediaQuery.of(context).size.width) * 0.26,
              height: (MediaQuery.of(context).size.height) * 0.5,
              decoration: BoxDecoration(
                color: AppColors.neutralColor,      
                border: Border(
                  top: BorderSide(width: MediaQuery.of(context).size.width * 0.02, color: AppColors.accentColor),
                  left: BorderSide(width: MediaQuery.of(context).size.width * 0.02, color: AppColors.accentColor),
                  bottom: BorderSide(width: MediaQuery.of(context).size.width * 0.02, color: AppColors.accentColor),
                  ),
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ColorSelection(),
                ],
              ),
            ),
          ),

          // Next settings button
          Positioned(
            top: (MediaQuery.of(context).size.height) * 0.76,
            child: NextSettingsButton(nextScreenWidget: GameScreen()),
          ),
        ],
      ),
    );
  }
}
