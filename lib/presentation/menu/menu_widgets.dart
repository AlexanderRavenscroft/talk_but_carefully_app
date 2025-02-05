import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/setup.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';

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
          EdgeInsets.symmetric(
            vertical: 0,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.56,
            MediaQuery.of(context).size.height * 0.12,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
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

      // Title: Row with icon and text
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

      // Content: Long scrollable text
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

      // Actions: Single button to close the dialog
      actions: [
        TextButton(
          style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(
              Size(
                double.maxFinite,
                MediaQuery.of(context).size.height * 0.078,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
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
          onPressed: () {
            Navigator.of(context).pop();
            playAudio(GameSounds.tapSound);
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



//====================[SETTINGS TEXT LABELS]====================
class SettingsText extends StatelessWidget {
  final String settingsTextString;
  const SettingsText({
    super.key,
    required this.settingsTextString,
  });

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
//====================[/SETTINGS TEXT LABELS]====================

//====================[SETTINGS BUTTONS]====================
class SettingsButton extends StatelessWidget {
  final VoidCallback settingsButtonPress;
  final IconData settingsButtonIcon;
  const SettingsButton({
    super.key,
    required this.settingsButtonPress,
    required this.settingsButtonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: settingsButtonPress,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.5,
            MediaQuery.of(context).size.height * 0.07,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
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
      child: Icon(
        settingsButtonIcon,
        color: AppColors.textColor,
        size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
      ),
    );
  }
}
//====================[/SETTINGS BUTTONS]====================