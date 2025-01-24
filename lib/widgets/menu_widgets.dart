import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';

//====================[MENU BUTTON]====================
class MenuButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(vertical: 0, horizontal: MediaQuery.of(context).size.width * 0.04),
        ),
        fixedSize: WidgetStateProperty.all(Size(
          MediaQuery.of(context).size.width * 0.56,
          MediaQuery.of(context).size.height * 0.12,
        )),
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        elevation: WidgetStateProperty.all(10.0),
        shadowColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            buttonIcon,
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.042,
          ),
          Expanded(
            child: Center(
              child: Text(
                buttonText,
                style: AppTypography.buttonStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.042,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//====================[/MENU BUTTON]====================

//====================[RULES POPUP]====================
class RulesDialog extends StatelessWidget {
  final IconData headingIcon;
  final String headingText;
  final String contentText;
  final String buttonText;

  const RulesDialog({
    super.key, 
    required this.headingIcon, 
    required this.headingText, 
    required this.contentText, 
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,
      // Title Row with icon and text
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            headingIcon, 
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.042,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            headingText, 
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ],
      ),
      // Content: Instructions for the game
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Text(
            textFiles[contentText] ?? 'Ładowanie tekstu...',
            textAlign: TextAlign.justify,
            style: AppTypography.descStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.024,
            ),
          ),
        ),
      ),
      // Actions: Button to close the dialog
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(double.maxFinite, MediaQuery.of(context).size.height * 0.075),
            backgroundColor: AppColors.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            playAudio(tapSound);
          },
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ),
      ],
    );
  }
}
//====================[/RULES POPUP]====================

//====================[SETTINGS POPUP]====================
class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,
      // Title Row with settings icon and text
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.settings_outlined, 
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.042,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.01),
          Text(
            "USTAWIENIA",
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ],
      ),
      // Content: Settings options
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Sound section
            SettingsText(settingsTextString: "Dźwięk:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SettingsButton(
              settingsButtonPress: () {
                setState(() {
                  soundToggled = !soundToggled;
                  PreferenceService.savePreference('soundToggled', soundToggled);
                });
                playAudio(optionSwitchSound);
              },
              settingsButtonIcon: soundToggled ? Icons.volume_up_rounded : Icons.volume_off,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // License & Agreement section
            SettingsText(settingsTextString: "Zgoda & Licencja:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SettingsButton(
              settingsButtonPress: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3), // Remove double-dialog stacking background problem
                  builder: (BuildContext context) {    
                    return RulesDialog(
                      headingIcon: Icons.assignment,
                      headingText: "REGULAMIN",
                      buttonText: "ZGADZAM SIĘ",
                      contentText: 'texts/agreement.txt',
                    );
                  },
                );
                playAudio(optionSwitchSound);
              },
              settingsButtonIcon: Icons.rule,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Authors section
            SettingsText(settingsTextString: "Autorzy:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SettingsButton(
              settingsButtonPress: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3), // Remove double-dialog stacking background problem
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: Icons.face,
                      headingText: "AUTORZY",
                      buttonText: "FAJNIE",
                      contentText: 'texts/authors.txt',
                    );
                  },
                );
                playAudio(optionSwitchSound);
              },
              settingsButtonIcon: Icons.face,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // App version and build number
            Text(
              "Wersja aplikacji: $appVersion\nKompilacja: $buildNumber",
              style: AppTypography.descBoldStyle.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ],
        ),
      ),
      // Actions: Button to close the dialog
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(double.maxFinite, MediaQuery.of(context).size.height * 0.075),
            backgroundColor: AppColors.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            playAudio(tapSound);
          },
          child: Text(
            "POWRÓT",
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ),
      ],
    );
  }
}
//====================[/SETTINGS POPUP]====================

//====================[Reusable widget for text labels]====================
class SettingsText extends StatelessWidget {
  final String settingsTextString;
  const SettingsText({super.key, required this.settingsTextString});

  @override
  Widget build(BuildContext context) {
    return Text(
      settingsTextString,
      style: AppTypography.descBoldStyle.copyWith(
        fontSize: MediaQuery.of(context).size.height * 0.034,
      ),
    );
  }
}
//====================[/Reusable widget for text labels]====================

//====================[Reusable widget for buttons]====================
class SettingsButton extends StatelessWidget {
  final VoidCallback settingsButtonPress;
  final IconData settingsButtonIcon;
  const SettingsButton({super.key, required this.settingsButtonPress, required this.settingsButtonIcon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: settingsButtonPress,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height * 0.07,
        )),
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.textColor, width: 2),
          ),
        ),
      ),
      child: Icon(
        settingsButtonIcon,
        color: AppColors.textColor,
        size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
      ),
    );
  }
}
//====================[/Reusable widget for buttons]====================
