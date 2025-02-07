import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';
import 'package:gadajaleostroznie/presentation/menu/menu_widgets.dart';
import 'package:gadajaleostroznie/presentation/settings/game_settings_screen.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:provider/provider.dart';

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
                       showDialog(
              context: context,
              builder: (BuildContext context) {
                return GameGuideDialog(
                  headingIcon: AppIcons.question,
                  headingText: "LEGENDA",
                  buttonText: "ROZUMIEM",
                );
              },
            );
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
            playAudio(GameSounds.optionSwitchSound);
           },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

 PauseSettingsButton(
              settingsButtonText: 'WYJDŻ',
              settingsButtonIcon: AppIcons.arrowBack,
              settingsButtonPress: () {
              resetGame();
              Navigator.pop(context, MaterialPageRoute(builder: (context) =>  GameSettingsScreen()));
                            context.read<GamePauseProvider>().pauseGame();
                playAudio(GameSounds.tapSound);
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
//====================[RULES POPUP]====================
class GameGuideDialog extends StatelessWidget {
  final IconData headingIcon;
  final String headingText;
  final String buttonText;

  const GameGuideDialog({
    super.key,
    required this.headingIcon,
    required this.headingText,
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

      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            spacing: 4,
            children: [
              Image.asset('assets/images/game-guide-pl.png'),
              Center(

                  child:  Text(
                          'RODZAJE PYTAŃ:',
                          textAlign: TextAlign.justify,
                          style: AppTypography.descBoldStyle.copyWith(
                            fontSize: MediaQuery.of(context).size.height * 0.034,
                          ),
                  ),
              ),
             GameGuideText(difIcon: AppIcons.tagFaces, difName: 'ŁATWE'),
             GameGuideText(difIcon: AppIcons.sentimentNeutral, difName: 'ŚREDNIE'),
             GameGuideText(difIcon: AppIcons.skull, difName: 'TRUDNE'),
            ],
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

class GameGuideText extends StatelessWidget {
  final IconData difIcon;
  final String difName;
  const GameGuideText({super.key, required this.difIcon, required this.difName});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                      difIcon,
                      size: MediaQuery.of(context).size.height * 0.046,
                    ),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    ' - ',
                    style: AppTypography.descBoldStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                    Expanded(
                      child: Text(
                        difName,
                        style: AppTypography.descBoldStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),

                ],
              );
  }
}

