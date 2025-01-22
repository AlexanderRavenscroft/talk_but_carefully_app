import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/screens/game_settings_screen.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/widgets/menu_widgets.dart';
import 'package:gadajaleostroznie/logic/globals.dart';

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
              buttonIcon: Icons.gamepad_rounded,
              buttonText: "GRAJ",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GameSettingsScreen()));
                playAudio(tapSound);
              },
            ),
          ),

          // RULES BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.63,
            child: MenuButton(
              buttonIcon: Icons.text_snippet_outlined,
              buttonText: "ZASADY",
              onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RulesDialog();
                  },
                );
                playAudio(tapSound);
              },
            )
          ),

          // SETTINGS BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.78,
            child: MenuButton(
              buttonIcon: Icons.settings_outlined,
              buttonText: "USTAWIENIA",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsDialog();
                  },
                );
                playAudio(tapSound);
              },
            )
          ),
        ],
      ),
    );
  }
}