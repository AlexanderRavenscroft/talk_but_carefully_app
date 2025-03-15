import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/presentation/widgets/menu/menu_widgets.dart';
import 'package:gadajaleostroznie/presentation/screens/game_settings/game_settings_screen.dart';
import 'package:gadajaleostroznie/presentation/screens/menu/menu_settings_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//====================[MENU SCREEN]====================
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // BACKGROUND SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/background-circles.svg',
              fit: BoxFit.cover,
            ),
          ),

          // LOGO
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22,
            child: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.contain,
            ),
          ),

          // PLAY BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            child: MenuButton(
              buttonIcon: AppIcons.gamepad,
              buttonText: AppLocalizations.of(context)!.play.toUpperCase(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameSettingsScreen(),
                  ),
                );
              },
            ),
          ),

          // RULES BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.63,
            child: MenuButton(
              buttonIcon: AppIcons.docText,
              buttonText: AppLocalizations.of(context)!.rules.toUpperCase(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: AppIcons.docText,
                      headingText: AppLocalizations.of(context)!.rules.toUpperCase(),
                      buttonText: AppLocalizations.of(context)!.okay.toUpperCase(),
                      contentText: 'texts/rules.txt',
                    );
                  },
                );
              },
            ),
          ),

          // SETTINGS BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.78,
            child: MenuButton(
              buttonIcon: AppIcons.settings,
              buttonText: AppLocalizations.of(context)!.settings.toUpperCase(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsMenu();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//====================[/MENU SCREEN]====================