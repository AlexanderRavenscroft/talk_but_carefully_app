import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/presentation/widgets/game_settings/game_settings_widgets.dart';
import 'package:gadajaleostroznie/presentation/screens/game_settings/team_settings_screen.dart';

//====================[GAME SETTINGS SCREEN]====================
class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => GameSettingsScreenState();
}

class GameSettingsScreenState extends State<GameSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Image.asset(
          'assets/images/logo.png',
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            AppIcons.arrowBack,
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // BODY
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/background-circles.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Difficulty Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            child: OptionsSelectionContainer(
              optionsText: "PYTANIA",
              selectionWidget: DifSelection(),
            ),
          ),

          // Skip Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            child: OptionsSelectionContainer(
              optionsText: "DOSTĘPNE POMINIĘCIA",
              selectionWidget: SkipSelection(),
            ),
          ),

          // Time Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.41,
            child: OptionsSelectionContainer(
              optionsText: "CZAS RUNDY",
              selectionWidget: TimeSelection(),
            ),
          ),

          // Points Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.59,
            child: OptionsSelectionContainer(
              optionsText: "LIMIT",
              selectionWidget: PointsSelection(),
            ),
          ),

          // Next Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.76,
            child: NextSettingsButton(
              nextScreenWidget: TeamSettingsScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
//====================[/GAME SETTINGS SCREEN]====================