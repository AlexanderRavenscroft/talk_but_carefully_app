import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/presentation/widgets/game_settings/team_settings_widgets.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/core/providers/ui_providers.dart'; 

//====================[TEAM SETTINGS SCREEN]====================
class TeamSettingsScreen extends StatefulWidget {
  const TeamSettingsScreen({super.key});

  @override
  State<TeamSettingsScreen> createState() => TeamSettingsScreenState();
}

class TeamSettingsScreenState extends State<TeamSettingsScreen> {
  
  TextEditingController teamAController = TextEditingController(text: teamA.name);
  TextEditingController teamBController = TextEditingController(text: teamB.name);

  @override
  Widget build(BuildContext context) {
    bool isToggled = context.watch<ToggleProvider>().isToggled;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // APPBAR
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.accentColor,
        shadowColor: Colors.transparent,
        toolbarHeight: (MediaQuery.of(context).size.height) * 0.08,
        title: Image.asset(
          'assets/images/game/logo_${Provider.of<LocaleProvider>(context).locale.languageCode}.png',
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
          // Bacground 
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Team A name input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    child: TeamNameTextArea(
                      controller: teamAController,
                      onChanged: (newText) {
                        setState(() {
                          teamA.name = newText;
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
                          teamB.name = newText;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Player List
          Positioned.fill(
            top: (MediaQuery.of(context).size.height) * 0.14,
            child: PlayerListScreen(players: isToggled ? teamB.players : teamA.players),
          ),

          // Team Color Picker
          Align(
            alignment: Alignment.centerRight,
            child: ColorPickerWidget(),
          ),
        ],
      ),
    );
  }
}
//====================[/TEAM SETTINGS SCREEN]====================