import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/l10n/lang_fix.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/presentation/widgets/game_settings/game_settings_widgets.dart';
import 'package:gadajaleostroznie/presentation/screens/game_settings/team_settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//====================[GAME SETTINGS SCREEN]====================
class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  State<GameSettingsScreen> createState() => GameSettingsScreenState();
}

class GameSettingsScreenState extends State<GameSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    // Translate team names correctly
    teamA.name = '${AppLocalizations.of(context)!.team.capitalize()} I';
    teamB.name = '${AppLocalizations.of(context)!.team.capitalize()} II';

    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Image.asset(
          'assets/images/game/logo_${Provider.of<LocaleProvider>(context).locale.languageCode}.png',
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
              'assets/images/game/background_circles.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Difficulty Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            child: OptionsSelectionContainer(
              optionsText: AppLocalizations.of(context)!.questions.toUpper(),
              selectionWidget: DifSelection(),
            ),
          ),

          // Skip Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            child: OptionsSelectionContainer(
              optionsText: AppLocalizations.of(context)!.availableSkips.toUpper(),
              selectionWidget: SkipSelection(),
            ),
          ),

          // Time Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.41,
            child: OptionsSelectionContainer(
              optionsText: AppLocalizations.of(context)!.timeLimit.toUpper(),
              selectionWidget: TimeSelection(),
            ),
          ),

          // Points Selection
          Positioned(
            top: MediaQuery.of(context).size.height * 0.59,
            child: OptionsSelectionContainer(
              optionsText: AppLocalizations.of(context)!.pointsToWin.toUpper(),
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