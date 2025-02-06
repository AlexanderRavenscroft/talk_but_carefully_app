import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';
import 'package:gadajaleostroznie/presentation/menu/menu_widgets.dart';

class PauseScreen extends StatefulWidget {
  const PauseScreen({super.key});

  @override
  State<PauseScreen> createState() => PauseScreenState();
}

class PauseScreenState extends State<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PauseSettingsButton(
          settingsButtonText: 'DŹWIĘK',
          settingsButtonIcon: GameSounds.soundToggled ? AppIcons.soundON : AppIcons.soundOFF,
          settingsButtonPress: () {
            setState(() {
              GameSounds.soundToggled = !GameSounds.soundToggled;
              PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
            });
            playAudio(GameSounds.optionSwitchSound);
           },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        PauseSettingsButton(
          settingsButtonText: 'JAK GRAĆ',
          settingsButtonIcon: AppIcons.question,
          settingsButtonPress: () {
            setState(() {
              GameSounds.soundToggled = !GameSounds.soundToggled;
              PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
            });
            playAudio(GameSounds.optionSwitchSound);
           },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        PauseSettingsButton(
          settingsButtonText: 'ZASADY',
          settingsButtonIcon: AppIcons.docText,
          settingsButtonPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return RulesDialog(
                  headingIcon: AppIcons.docText,
                  headingText: "ZASADY",
                  buttonText: "DOBRA",
                  contentText: 'texts/rules.txt',
                );
              },
            );
            playAudio(GameSounds.tapSound);
           },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        PauseSettingsButton(
          settingsButtonText: 'WYJDŻ',
          settingsButtonIcon: AppIcons.arrowBack,
          settingsButtonPress: () {
            setState(() {
              GameSounds.soundToggled = !GameSounds.soundToggled;
              PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
            });
            playAudio(GameSounds.optionSwitchSound);
           },
        ),
      ]
    );
  }
}
//====================[MENU BUTTON]====================
//====================[SETTINGS BUTTONS]====================
class PauseSettingsButton extends StatelessWidget {
  final VoidCallback settingsButtonPress;
  final IconData settingsButtonIcon;
  final String settingsButtonText;

  const PauseSettingsButton({
    super.key,
    required this.settingsButtonPress,
    required this.settingsButtonIcon,
    required this.settingsButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: settingsButtonPress,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.8,
            MediaQuery.of(context).size.height * 0.08,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: AppColors.textColor,
              width: 2,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            settingsButtonText,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            )
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Icon(
            settingsButtonIcon,
            color: AppColors.textColor,
            size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
          ),
        ],
      ),
    );
  }
}
//====================[/SETTINGS BUTTONS]====================